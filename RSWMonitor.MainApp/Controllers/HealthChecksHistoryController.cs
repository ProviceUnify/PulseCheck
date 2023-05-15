using ClosedXML.Excel;
using DocumentFormat.OpenXml.Spreadsheet;
using IronPdf;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using RSWMonitor.MainApp.Models;
using System.Data;
using System.Globalization;
using System.Linq;

namespace RSWMonitor.MainApp.Controllers
{
    [Route("HealthChecksHistory/{action=Index}/{top?}")]
    [Authorize(Policy = "HealthManagers")]
    public class HealthChecksHistoryController : Controller
    {
        private readonly HealthChecksDBContext HealthChecksDbContext;
        private readonly UserManager<IdentityUser> _userManager;
        private readonly AddEntryToUserActionHistoryController addEntry;

        public HealthChecksHistoryController(HealthChecksDBContext HCContext, UserManager<IdentityUser> userManager)
        {
            HealthChecksDbContext = HCContext;
            _userManager = userManager;
            addEntry = new AddEntryToUserActionHistoryController(HealthChecksDbContext, _userManager);
        }
        public IActionResult Index()
        {
            Dictionary<int, string> foundConfigurations = new();
            foreach (var t in from item in HealthChecksDbContext.Executions.ToList()
                              let t = HealthChecksDbContext.Configurations.Where(s => s.Name == item.Name && s.Uri == item.Uri)
                              select t)
            {
                try
                {
                    foundConfigurations.Add(t.First().Id, t.First().Name);
                }
                catch { }
            }

            var history = HealthChecksDbContext.Executions.Include(s => s.HealthCheckExecutionHistories).ToList();
            ViewBag.Statuses = HealthChecksDbContext.HealthStatuses.ToList();
            ViewData.Add(new KeyValuePair<string, object?>("foundConfigurations", foundConfigurations));
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
            string fileName = "history.xlsx";
            var renderer = new HtmlToPdf();
            string htmlOfPdf = "";
            var history = HealthChecksDbContext.Executions.ToList();
            if (status < 0)
            {
                history = HealthChecksDbContext.Executions.Include(s => s.HealthCheckExecutionHistories.Where(s => s.On.Date >= startDate && s.On.Date <= endDate)).ToList();
            }
            else
            {
                history = HealthChecksDbContext.Executions.Include(s => s.HealthCheckExecutionHistories.Where(s => s.On.Date >= startDate && s.On.Date <= endDate && s.StatusNavigation.StatusId == status)).ToList();
            }
            var healthStatuses = HealthChecksDbContext.HealthStatuses.ToList();

            var stream = new MemoryStream();
            var streamOutput = new MemoryStream();

            string statusWord = (status < 0) ? "All" : healthStatuses.Where(s => s.StatusId == status).First().StatusName;
            string startDateWord = (startDate == DateTime.Parse("01.01.0001")) ? "---" : startDate.ToString();
            string endDateWord = (endDate == DateTime.Parse("31.12.9999")) ? "---" : endDate.ToString();
            if (fileType == 0)
            {
                using var workbook = new XLWorkbook();
                var worksheet = workbook.Worksheets.Add("History");
                worksheet.Cell($"A1").Value = "Searched status:";
                worksheet.Cell($"B1").Value = statusWord;
                worksheet.Cell($"A2").Value = "Searched start date:";
                worksheet.Cell($"B2").Value = startDateWord;
                worksheet.Cell($"A3").Value = "Searched end date:";
                worksheet.Cell($"B3").Value = endDateWord;
                var r = 5;
                worksheet.Range($"A{r}:F{r}").Style = XLWorkbook.DefaultStyle.Font.SetBold();

                worksheet.Cell(r, 1).Value = "#";
                worksheet.Range($"B{r}:C{r}").Merge().Value = "Configuration name";
                worksheet.Range($"D{r}:F{r}").Merge().Value = "URI";
                foreach (var exec in history)
                {
                    r++;
                    worksheet.Cell(r, 1).Value = exec.Id;
                    worksheet.Range($"B{r}:C{r}").Merge().Value = exec.Name;
                    worksheet.Range($"D{r}:F{r}").Merge().Value = exec.Uri;
                    if (exec.HealthCheckExecutionHistories.Count > 0)
                    {
                        r++;
                        worksheet.Cell(r, 2).Value = "#";
                        worksheet.Cell(r, 3).Value = "Component name";
                        worksheet.Cell(r, 4).Value = "Failure description";
                        worksheet.Cell(r, 5).Value = "Status";
                        worksheet.Cell(r, 6).Value = "Time";
                        worksheet.Range($"B{r}:F{r}").Style = XLWorkbook.DefaultStyle.Font.SetBold();
                        foreach (var historyEntry in exec.HealthCheckExecutionHistories)
                        {
                            r++;
                            worksheet.Cell(r, 2).Value = historyEntry.Id;
                            worksheet.Cell(r, 3).Value = historyEntry.Name;
                            worksheet.Cell(r, 4).Value = historyEntry.Description;
                            worksheet.Cell(r, 5).Value = healthStatuses.Where(s => s.StatusId == historyEntry.Status).First().StatusName;
                            worksheet.Cell(r, 6).Value = historyEntry.On;
                        }
                    }
                }
                workbook.SaveAs(stream);
            }
            else if (fileType == 1)
            {
                contentType = "application/pdf";
                fileName = "history.pdf";
                htmlOfPdf += $"<h3 style='font-family: Calibri'>Searched status: {statusWord}</h3>";
                htmlOfPdf += $"<h3 style='font-family: Calibri'>Searched start date: {startDateWord}</h3>";
                htmlOfPdf += $"<h3 style='font-family: Calibri'>Searched end date: {endDateWord}</h3>";
                htmlOfPdf += "<br /><style>th {min-width:130px; max-width:130px} tr:nth-child(even) { background-color: #f2f2f2;}</style>";
                foreach (var exec in history)
                {
                    htmlOfPdf += "<table class='table' style='font-family: Calibri'>";
                    htmlOfPdf += $"<tr style='background-color: lightgrey;'><th style='min-width:30px; max-width:30px'>#</th><th>Configuration name</th><th>URI</th></tr>";
                    htmlOfPdf += $"<tr><td>{exec.Id}</td><td>{exec.Name}</td><td>{exec.Uri}</td></tr>";
                    if (exec.HealthCheckExecutionHistories.Count > 0)
                    {
                        htmlOfPdf += $"<tr><td colspan='3'><table style='font-family: Calibri'><tr style='background-color: lightgrey;'><th>#</th><th>Component name</th><th style='min-width:200px; max-width:200px'>Failure description</th><th>Status</th><th>Time</th></tr>";
                        foreach (var historyEntry in exec.HealthCheckExecutionHistories)
                        {
                            htmlOfPdf += $"<tr><td>{historyEntry.Id}</td><td>{historyEntry.Name}</td><td>{historyEntry.Description}</td><td>{healthStatuses.Where(s => s.StatusId == historyEntry.Status).First().StatusName}</td><td>{historyEntry.On}</td></tr>";
                        }
                        htmlOfPdf += "</table></td></tr>";
                    }
                    else
                    {
                        htmlOfPdf += $"<tr><td colspan='3'><table style='font-family: Calibri'><tr style='background-color: lightgrey;'><th></th><th></th><th>No data</th><th></th><th></th></tr></table></td></tr>";
                    }
                }
                htmlOfPdf += "</table>";
                stream = renderer.RenderHtmlAsPdf(htmlOfPdf).Stream;
            }
            var content = stream.ToArray();
            //return RedirectToAction("Index");
            await addEntry.Add(User, 4, $"Requesting report about health statuses!");
            return File(content, contentType, fileName);
        }
    }
}
