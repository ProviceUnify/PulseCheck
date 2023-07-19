using Microsoft.AspNetCore.Mvc;
using Microsoft.Web.Administration;
using RSWMonitor.RemoteMonitor.Controllers;

namespace RSWMonitor.RemoteMonitor.Services
{
    public class ConfigurationService : Controller
    {
        private readonly IHostApplicationLifetime _applicationLifetime;
        private readonly IConfiguration _configuration;
        private readonly ILogger<Controller> _logger;

        public ConfigurationService(IConfiguration configuration, ILogger<Controller> logger, IHostApplicationLifetime applicationLifetime)
        {
            _configuration = configuration;
            _logger = logger;
            _applicationLifetime = applicationLifetime;
        }
        public async Task<IActionResult> RestartConfiguration(ControlParams controlParams)
        {
            try
            {
                using IISSiteService.ISiteServices services = new IISSiteService.SiteServices();
                string siteName = _configuration.GetValue<String>("IISSiteName");
                _logger.LogInformation($"(Configuration ID: {controlParams.id}) applying settings for IIS site called as \"{siteName}\"...");
                Site site = services.GetSite(siteName);
                _applicationLifetime.StopApplication();
                bool isRestarted = services.StartSite(siteName);
                _logger.LogInformation($"(Configuration ID: {controlParams.id}) was IIS site \"{siteName}\" restarted? {isRestarted}");
                return Ok();
            }
            catch (Exception ex)
            {
                _logger.LogError($"(Configuration ID: {controlParams.id}) applying settings error for IIS site got exception: {ex}");
                return BadRequest(Json(new { value = $"Unable apply settings for configuration: {ex.Message}" }));
            }
        }
    }
}
