using ClosedXML.Excel;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using RSWMonitor.MainApp.Models;
using System.Globalization;

namespace RSWMonitor.MainApp.Controllers
{
    [Route("UserActionsHistory/{action=Index}/{top?}")]
    [Authorize(Policy = "UserManagers")]
    public class UserActionsHistoryController : Controller
    {
        private readonly HealthChecksDBContext HealthChecksDbContext;
        private readonly UserManager<IdentityUser> _userManager;
        private readonly AddEntryToUserActionHistoryController addEntry;
        public UserActionsHistoryController(HealthChecksDBContext HCContext, UserManager<IdentityUser> userManager)
        {
            HealthChecksDbContext = HCContext;
            _userManager = userManager;
            addEntry = new AddEntryToUserActionHistoryController(HealthChecksDbContext, _userManager);
        }
        public IActionResult Index()
        {
            var history = HealthChecksDbContext.HealthCheckUserActionLogs.Include(u => u.User).Include(a => a.UserAction).ToList();
            List<UserAction> userActions = HealthChecksDbContext.UserActions.ToList();
            ViewBag.UserActions = HealthChecksDbContext.UserActions.ToList();


            return View(history);
        }
        [HttpPost]
        public async Task<IActionResult> DownloadHistory(IFormCollection formCollection)
        {
            byte fileType = 0;
            sbyte status = -1;
            var culture = new CultureInfo("ru-RU");
            DateTime startDate = DateTime.Parse("01.01.0001", culture);
            DateTime endDate = DateTime.Parse("31.12.9999", culture);
            try
            {
                fileType = Byte.Parse(formCollection["fileType"]);

            }
            catch { }
            try
            {
                try
                {
                    try
                    {
                        status = SByte.Parse(formCollection["status"]);
                    }
                    catch { }
                    startDate = DateTime.Parse(formCollection["startDate"]);
                }
                catch { }
                endDate = DateTime.Parse(formCollection["endDate"]);
            }
            catch { }
            string contentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            string fileName = "user-actions-history.xlsx";
            var renderer = new HtmlToPdf();
            string htmlOfPdf = "";
            var history = HealthChecksDbContext.HealthCheckUserActionLogs.ToList();
            if (status < 0)
            {
                history = HealthChecksDbContext.HealthCheckUserActionLogs.Include(u => u.User).Include(a => a.UserAction).Where(s => s.Datetime >= startDate && s.Datetime <= endDate).ToList();
            }
            else
            {
                history = HealthChecksDbContext.HealthCheckUserActionLogs.Include(u => u.User).Include(a => a.UserAction).Where(s => s.Datetime >= startDate && s.Datetime <= endDate && s.UserAction.UserActionId == status).ToList();
            }
            var actions = HealthChecksDbContext.UserActions.ToList();

            var stream = new MemoryStream();
            var streamOutput = new MemoryStream();

            string statusWord = (status < 0) ? "All" : actions.Where(s => s.UserActionId == status).First().UserActionName;
            string startDateWord = (startDate == DateTime.Parse("01.01.0001")) ? "---" : startDate.ToString();
            string endDateWord = (endDate == DateTime.Parse("31.12.9999")) ? "---" : endDate.ToString();
            if (fileType == 0)
            {
                using var workbook = new XLWorkbook();
                var worksheet = workbook.Worksheets.Add("History");
                worksheet.Cell($"A1").Value = "Searched action:";
                worksheet.Cell($"B1").Value = statusWord;
                worksheet.Cell($"A2").Value = "Searched start date:";
                worksheet.Cell($"B2").Value = startDateWord;
                worksheet.Cell($"A3").Value = "Searched end date:";
                worksheet.Cell($"B3").Value = endDateWord;
                var r = 5;
                worksheet.Range($"A{r}:F{r}").Style = XLWorkbook.DefaultStyle.Font.SetBold();

                worksheet.Range($"A{r}").Value = "#";
                worksheet.Range($"B{r}").Value = "User name";
                worksheet.Range($"C{r}").Value = "Action";
                worksheet.Range($"D{r}").Value = "Action details";
                worksheet.Range($"E{r}").Value = "Time";
                foreach (var exec in history)
                {
                    r++;
                    worksheet.Range($"A{r}").Value = exec.UserActionEntryId;
                    worksheet.Range($"B{r}").Value = exec.User.UserName;
                    worksheet.Range($"C{r}").Value = exec.UserAction.UserActionName;
                    worksheet.Range($"D{r}").Value = exec.ActionDetails;
                    worksheet.Range($"E{r}").Value = exec.Datetime;
                }
                workbook.SaveAs(stream);
            }
            else if (fileType == 1)
            {
                contentType = "application/pdf";
                fileName = "user-actions-history.pdf";
                htmlOfPdf += $"<h3 style='font-family: Calibri'>Searched status: {statusWord}</h3>";
                htmlOfPdf += $"<h3 style='font-family: Calibri'>Searched start date: {startDateWord}</h3>";
                htmlOfPdf += $"<h3 style='font-family: Calibri'>Searched end date: {endDateWord}</h3>";
                htmlOfPdf += "<br /><style>th {min-width:130px; max-width:130px} tr:nth-child(even) { background-color: #f2f2f2;}</style>";
                foreach (var exec in history)
                {
                    htmlOfPdf += "<table class='table' style='font-family: Calibri'>";
                    htmlOfPdf += $"<tr style='background-color: lightgrey;'><th style='min-width:30px; max-width:30px'>#</th><th>User name</th><th>Action</th><th>Action details</th><th>Time</th></tr>";
                    htmlOfPdf += $"<tr><td>{exec.UserActionEntryId}</td><td>{exec.User.UserName}</td><td>{exec.UserAction.UserActionName}</td><td>{exec.ActionDetails}</td><td>{exec.Datetime}</td></tr>";
                    
                }
                htmlOfPdf += "</table>";
                stream = renderer.RenderHtmlAsPdf(htmlOfPdf).Stream;
            }
            var content = stream.ToArray();
            //return RedirectToAction("Index");
            await addEntry.Add(User, 5, $"Requesting report about users actions!");
            return File(content, contentType, fileName);
        }
    }
}
