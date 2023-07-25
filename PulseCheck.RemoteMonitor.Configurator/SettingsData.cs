namespace PulseCheck.RemoteMonitor.Configurator
{
    internal class ConnectionStrings
    {
        public string AspDBConnectionString = "";
        public string HealthChecksDBString = "";
    }

    internal class Logging
    {
        public object? LogLevel = null;
    }

    internal class SettingsData
    {
        public ConnectionStrings? ConnectionStrings = null;
        public Logging? Logging = null;
        public string AllowedHosts = "";

        public int ConfigurationID = -1;
        public string Urls = "";
        public string IISSiteName = "";
        public bool Configured = false;
    }
}

