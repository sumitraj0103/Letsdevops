using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;
using MachineInventoryProcessor.Models;
using MachineInventoryProcessor.Services;
using Newtonsoft.Json;
using System.IO;
using System.Threading.Tasks;

namespace MachineInventoryProcessor
{
    public class BlobTriggerFunction
    {
        private readonly ILogger<BlobTriggerFunction> _logger;

        public BlobTriggerFunction(ILogger<BlobTriggerFunction> logger)
        {
            _logger = logger;
        }

        [Function(nameof(ProcessMachineInventory))]
        public async Task ProcessMachineInventory(
            [BlobTrigger("machine-inventory/{name}", Connection = "AzureWebJobsStorage")] Stream blobStream,
            string name)
        {
            _logger.LogInformation($"Processing blob: {name}");
            _logger.LogInformation($"Blob Size: {blobStream.Length} bytes");

            try
            {
                // Read JSON content from blob
                using (StreamReader reader = new StreamReader(blobStream))
                {
                    string jsonContent = await reader.ReadToEndAsync();
                    _logger.LogInformation($"JSON Content Length: {jsonContent.Length}");

                    // Deserialize JSON to MachineInfo object
                    var machineInfo = JsonConvert.DeserializeObject<MachineInfo>(jsonContent);

                    if (machineInfo == null)
                    {
                        _logger.LogError($"Failed to deserialize JSON for blob: {name}");
                        return;
                    }

                    _logger.LogInformation($"Successfully deserialized data for: {machineInfo.ComputerName}");

                    // Get SQL connection string from environment variable
                    string sqlConnectionString = Environment.GetEnvironmentVariable("SqlConnectionString");

                    if (string.IsNullOrEmpty(sqlConnectionString))
                    {
                        _logger.LogError("SqlConnectionString not found in application settings");
                        return;
                    }

                    // Insert into SQL Server
                    var dbService = new DatabaseService(sqlConnectionString, _logger);
                    bool success = await dbService.InsertMachineInfoAsync(machineInfo);

                    if (success)
                    {
                        _logger.LogInformation($"Successfully processed and stored data for {machineInfo.ComputerName}");
                    }
                    else
                    {
                        _logger.LogWarning($"Insert operation returned false for {machineInfo.ComputerName}");
                    }
                }
            }
            catch (JsonException jsonEx)
            {
                _logger.LogError(jsonEx, $"JSON deserialization error for blob: {name}");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"Error processing blob: {name}");
                throw;
            }
        }
    }
}