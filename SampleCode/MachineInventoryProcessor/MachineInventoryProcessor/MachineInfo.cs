using Newtonsoft.Json;

namespace MachineInventoryProcessor.Models
{
    public class MachineInfo
    {
        public string ComputerName { get; set; }
        public string Domain { get; set; }
        public string Manufacturer { get; set; }
        public string Model { get; set; }
        public string Chassis { get; set; }
        public string User { get; set; }
        public string UserDomain { get; set; }

        public string OSName { get; set; }
        public string OSVersion { get; set; }
        public string OSBuild { get; set; }
        public string OSArchitecture { get; set; }
        public int ServicePack { get; set; }
        public string InstallDate { get; set; }
        public string LastBoot { get; set; }
        public string Uptime { get; set; }

        public string BIOSManufacturer { get; set; }
        public string BIOSVersion { get; set; }
        public string SerialNumber { get; set; }

        public string Processor { get; set; }
        public int ProcessorCores { get; set; }
        public int ProcessorLogicalProcessors { get; set; }
        public decimal TotalPhysicalMemoryGB { get; set; }
        public decimal TotalDiskSpaceGB { get; set; }
        public decimal FreeDiskSpaceGB { get; set; }
        public decimal UsedDiskSpaceGB { get; set; }

        public List<NetworkAdapter> NetworkAdapters { get; set; }

        public string CollectionDate { get; set; }
        public string ScriptVersion { get; set; }
    }

    public class NetworkAdapter
    {
        public string Description { get; set; }
        public string MACAddress { get; set; }
        public string IPAddress { get; set; }
        public string SubnetMask { get; set; }
        public string DefaultGateway { get; set; }
        public bool DHCPEnabled { get; set; }
        public string DNSServers { get; set; }
    }
}