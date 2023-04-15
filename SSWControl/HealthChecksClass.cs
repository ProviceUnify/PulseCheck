namespace SSWControl.Monitor
{
    public class HealthCheckEntries
    {
        public string? Name { get; set; }
        public string? Uri { get; set; }
    }

    public class HealthChecksUI
    {
        public List<HealthCheckEntries> HealthChecks = new List<HealthCheckEntries>();
        public string? PollingRate = "10";
    }

    public class HealthChecksClass
    {
        public HealthChecksUI HealthChecksUI = new HealthChecksUI();
    }
}
