namespace RSWMonitor.MainApp.Models
{
    public class Configurations
    {
        public int Id { get; set; }
        public string Uri { get; set; }
        public string Name { get; set; }
        public string? DiscoveryService { get; set; }

        //public Configurations(int Id_, string Uri_, string Name_, string DiscoveryService_)
        //{
        //    this.Id = Id_;
        //    this.Uri = Uri_;
        //    this.Name = Name_;
        //    this.DiscoveryService = DiscoveryService_;
        //}
    }
}
