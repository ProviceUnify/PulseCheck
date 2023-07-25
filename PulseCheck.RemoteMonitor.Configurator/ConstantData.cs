namespace PulseCheck.RemoteMonitor.Configurator
{
    internal class ConstantData
    {
        internal class SavingCancelledException : Exception { }

        public static List<string> settingsNames = new()
        {
                "Configuration ID",
                "Urls",
                "IIS site name",
                "Configured"
        };

        public static Func<string, string> readUserUserInput = x =>
        {
            var line = Console.ReadLine();
            if (line != null) if (line != "") return line; else return x;
            return x;
        };

        public static string appsettingsFilePath = "appsettings.production.json";
        public static string header = $"======================== {appsettingsFilePath} configurator v.1.0 ========================\n";
    }
}
