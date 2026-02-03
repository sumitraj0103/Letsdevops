using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Logging;
using MachineInventoryProcessor.Models;
using System;
using System.Threading.Tasks;

namespace MachineInventoryProcessor.Services
{
    public class DatabaseService
    {
        private readonly string _connectionString;
        private readonly ILogger _logger;

        public DatabaseService(string connectionString, ILogger logger)
        {
            _connectionString = connectionString;
            _logger = logger;
        }

        public async Task<bool> InsertMachineInfoAsync(MachineInfo machineInfo)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(_connectionString))
                {
                    await conn.OpenAsync();
                    _logger.LogInformation($"Connected to SQL Server for {machineInfo.ComputerName}");

                    string query = @"
                        INSERT INTO MachineInventory 
                        (ComputerName, Domain, Manufacturer, Model, Chassis, [User], UserDomain,
                         OSName, OSVersion, OSBuild, OSArchitecture, ServicePack, InstallDate, 
                         LastBoot, Uptime, BIOSManufacturer, BIOSVersion, SerialNumber,
                         Processor, ProcessorCores, ProcessorLogicalProcessors, 
                         TotalPhysicalMemoryGB, TotalDiskSpaceGB, FreeDiskSpaceGB, UsedDiskSpaceGB,
                         IPAddress, MACAddress, CollectionDate, ScriptVersion)
                        VALUES 
                        (@ComputerName, @Domain, @Manufacturer, @Model, @Chassis, @User, @UserDomain,
                         @OSName, @OSVersion, @OSBuild, @OSArchitecture, @ServicePack, @InstallDate,
                         @LastBoot, @Uptime, @BIOSManufacturer, @BIOSVersion, @SerialNumber,
                         @Processor, @ProcessorCores, @ProcessorLogicalProcessors,
                         @TotalPhysicalMemoryGB, @TotalDiskSpaceGB, @FreeDiskSpaceGB, @UsedDiskSpaceGB,
                         @IPAddress, @MACAddress, @CollectionDate, @ScriptVersion)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@ComputerName", machineInfo.ComputerName ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@Domain", machineInfo.Domain ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@Manufacturer", machineInfo.Manufacturer ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@Model", machineInfo.Model ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@Chassis", machineInfo.Chassis ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@User", machineInfo.User ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@UserDomain", machineInfo.UserDomain ?? (object)DBNull.Value);

                        cmd.Parameters.AddWithValue("@OSName", machineInfo.OSName ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@OSVersion", machineInfo.OSVersion ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@OSBuild", machineInfo.OSBuild ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@OSArchitecture", machineInfo.OSArchitecture ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@ServicePack", machineInfo.ServicePack);
                        cmd.Parameters.AddWithValue("@InstallDate", ParseDate(machineInfo.InstallDate));
                        cmd.Parameters.AddWithValue("@LastBoot", ParseDate(machineInfo.LastBoot));
                        cmd.Parameters.AddWithValue("@Uptime", machineInfo.Uptime ?? (object)DBNull.Value);

                        cmd.Parameters.AddWithValue("@BIOSManufacturer", machineInfo.BIOSManufacturer ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@BIOSVersion", machineInfo.BIOSVersion ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@SerialNumber", machineInfo.SerialNumber ?? (object)DBNull.Value);

                        cmd.Parameters.AddWithValue("@Processor", machineInfo.Processor ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@ProcessorCores", machineInfo.ProcessorCores);
                        cmd.Parameters.AddWithValue("@ProcessorLogicalProcessors", machineInfo.ProcessorLogicalProcessors);
                        cmd.Parameters.AddWithValue("@TotalPhysicalMemoryGB", machineInfo.TotalPhysicalMemoryGB);
                        cmd.Parameters.AddWithValue("@TotalDiskSpaceGB", machineInfo.TotalDiskSpaceGB);
                        cmd.Parameters.AddWithValue("@FreeDiskSpaceGB", machineInfo.FreeDiskSpaceGB);
                        cmd.Parameters.AddWithValue("@UsedDiskSpaceGB", machineInfo.UsedDiskSpaceGB);

                        // Get first network adapter info
                        var primaryAdapter = machineInfo.NetworkAdapters?.FirstOrDefault();
                        cmd.Parameters.AddWithValue("@IPAddress", primaryAdapter?.IPAddress ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@MACAddress", primaryAdapter?.MACAddress ?? (object)DBNull.Value);

                        cmd.Parameters.AddWithValue("@CollectionDate", ParseDate(machineInfo.CollectionDate));
                        cmd.Parameters.AddWithValue("@ScriptVersion", machineInfo.ScriptVersion ?? (object)DBNull.Value);

                        int rowsAffected = await cmd.ExecuteNonQueryAsync();
                        _logger.LogInformation($"Successfully inserted {rowsAffected} row(s) for {machineInfo.ComputerName}");

                        return rowsAffected > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"Error inserting data for {machineInfo.ComputerName}");
                throw;
            }
        }

        private DateTime ParseDate(string dateString)
        {
            if (DateTime.TryParse(dateString, out DateTime result))
            {
                return result;
            }
            return DateTime.MinValue;
        }
    }
}