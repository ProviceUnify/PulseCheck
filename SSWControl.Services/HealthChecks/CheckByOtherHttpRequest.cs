using Microsoft.Extensions.Diagnostics.HealthChecks;

namespace SSWControl.Services.HealthChecks
{
    public class CheckByOtherHttpRequest : IHealthCheck
    {
        public async Task<HealthCheckResult> CheckHealthAsync(HealthCheckContext context, CancellationToken cancellationToken = default)
        {
            using var client = new HttpClient();
            using var response = await client.GetAsync("https://rutracker.org/", cancellationToken);
            if (!response.IsSuccessStatusCode)
            {
                return HealthCheckResult.Unhealthy($"HTTP request failed with status code {response.StatusCode}");
            }

            // You can add additional checks here based on the response content

            return HealthCheckResult.Healthy("Connection to google.com is OK");

        }
    }
}
