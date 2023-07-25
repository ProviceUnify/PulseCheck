using Newtonsoft.Json;
using static PulseCheck.RemoteMonitor.Configurator.ConstantData;

namespace PulseCheck.RemoteMonitor.Configurator
{
    internal class Program
    {
        static void Main(string[] args)
        {
            PrintHeader();
            Console.WriteLine(" Preparing...");
            Console.ForegroundColor = ConsoleColor.Green;
            try
            {
                string appsettings = File.ReadAllText(appsettingsFilePath);
                Console.WriteLine(" + \"appsettings.production.json\" file found;");
                var deserializedettings = JsonConvert.DeserializeObject<SettingsData>(appsettings);
                Console.WriteLine(" + Deserialization complete;\n");
                if (deserializedettings!.Configured)
                {
                    Console.ForegroundColor = ConsoleColor.Blue;
                    Console.WriteLine(" + This site's appconfig is configured.\n ~ Press:\n\t[Enter]\t- Show settings & exit (Default);\n\t[Space]\t- Change settings");
                    var key = Console.ReadKey(true).Key;
                    switch (key)
                    {
                        case ConsoleKey.Enter:
                            ShowAllSettings(deserializedettings);
                            Console.WriteLine("Press any key to exit");
                            Console.ReadKey();
                            return;
                        case ConsoleKey.Spacebar:
                            EditSettings(deserializedettings);
                            SaveSettings(deserializedettings);
                            return;
                    }
                }
                else
                {
                    StartupSettings(deserializedettings);
                    try
                    {
                        EditSettings(deserializedettings);
                    }
                    catch (SavingCancelledException)
                    {
                        return;
                    }
                    SaveSettings(deserializedettings);
                    return;
                }
                Console.ForegroundColor = ConsoleColor.Green;


            }
            catch (Exception ex)
            {
                PrintException(ex);
            }
        }

        static void SaveSettings(SettingsData deserializedData)
        {
            Console.Clear();
            PrintHeader();
            Console.ForegroundColor = ConsoleColor.Green;
            Console.WriteLine("Saving...");
            try
            {
                deserializedData.Configured = true;
                var appsettings = JsonConvert.SerializeObject(deserializedData, Formatting.Indented);
                File.WriteAllText(appsettingsFilePath, appsettings);
            }
            catch (Exception ex)
            {
                PrintException(ex);
            }
            Console.WriteLine("Successfully saved!");
        }


        static void StartupSettings(SettingsData deserializedData)
        {
            Console.Clear();
            PrintHeader();
            ShowAllSettings(deserializedData);
            Console.Write(" ~ Configuration in progress. Write down neccessary settings one after another: \n");

            Console.Write($" > {settingsNames[0]}: ");
            var ConfiguationID = deserializedData.ConfigurationID;
            deserializedData.ConfigurationID = Int32.Parse(readUserUserInput(ConfiguationID.ToString()));

            Console.Write($" > {settingsNames[1]}: ");
            var Urls = deserializedData.Urls;
            deserializedData.Urls = readUserUserInput(Urls);

            Console.Write($" > {settingsNames[2]}: ");
            var IISSiteName = deserializedData.IISSiteName;
            deserializedData.IISSiteName = readUserUserInput(IISSiteName);

            return;
        }

        static void EditSettings(SettingsData deserializedData)
        {


            while (true)
            {
                Console.Clear();
                PrintHeader();
                ShowAllSettings(deserializedData);
                Console.Write(" ~ Press:\n\t[Enter]\t- Save settings & exit;\n\t[Esc]\t- Exit without saving;\n\t[0 - 2]\t- Edit settings: ");
                var key = Console.ReadKey(false).Key;
                if (key == ConsoleKey.Enter) return;
                try
                {
                    switch (key)
                    {
                        case ConsoleKey.D0:
                            Console.Write($"\n{settingsNames[0]}: ");
                            var ConfiguationID = deserializedData.ConfigurationID;
                            deserializedData.ConfigurationID = Int32.Parse(readUserUserInput(ConfiguationID.ToString()));
                            break;
                        case ConsoleKey.D1:
                            Console.Write($"\n{settingsNames[1]}: ");
                            var Urls = deserializedData.Urls;
                            deserializedData.Urls = readUserUserInput(Urls);
                            break;
                        case ConsoleKey.D2:
                            Console.Write($"\n{settingsNames[2]}: ");
                            var IISSiteName = deserializedData.IISSiteName;
                            deserializedData.IISSiteName = readUserUserInput(IISSiteName);
                            break;
                        case ConsoleKey.Escape:
                            throw new SavingCancelledException();
                        default:
                            continue;
                    }
                }
                catch (SavingCancelledException)
                {
                    throw;
                }
                catch (Exception)
                {
                    continue;
                }
            }
        }

        static void PrintException(Exception ex)
        {
            var previousColor = Console.ForegroundColor;
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine($"\n{ex}");
            Console.ForegroundColor = previousColor;
        }

        static void PrintHeader()
        {
            var previousColor = Console.ForegroundColor;
            Console.ForegroundColor = ConsoleColor.Yellow;
            Console.WriteLine(header);
            Console.ForegroundColor = previousColor;
        }

        static void ShowAllSettings(SettingsData deserializedData)
        {
            Console.ForegroundColor = ConsoleColor.White;
            Console.WriteLine("===========================================================");
            Console.WriteLine($" >     {settingsNames[3]}:\t\t{deserializedData.Configured}");
            Console.WriteLine("===========================================================");
            Console.WriteLine($" > [0] {settingsNames[0]}:\t{deserializedData.ConfigurationID}");
            Console.WriteLine($" > [1] {settingsNames[1]}:\t\t\t\"{deserializedData.Urls}\"");
            Console.WriteLine($" > [2] {settingsNames[2]}:\t\t\"{deserializedData.IISSiteName}\"");
            Console.WriteLine("===========================================================");
            Console.ForegroundColor = ConsoleColor.Blue;
        }
    }
}

#region file template
/*
{
    "ConnectionStrings": {
        "AspDBConnectionString": "Server=localhost;Database=HealthChecksDB;User Id=PC_RemoteMonitor;Password=PulseCheck2;MultipleActiveResultSets=true",
    "HealthChecksDBString": "Server=localhost;Database=HealthChecksDB;User Id=PC_RemoteMonitor;Password=PulseCheck2;MultipleActiveResultSets=true"
    },
  "Logging": {
        "LogLevel": {
            "Default": "Information",
      "Microsoft.AspNetCore": "Warning"
        }
    },
  "AllowedHosts": "*",
  "ConfigurationID": 33,
  "Urls": "http://localhost:5001",
  "IISSiteName": "Worker",
  "Configured": "True"
}
*/
#endregion