using System;
using Azure.Identity;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Configuration;

var host = new HostBuilder()
    .ConfigureFunctionsWorkerDefaults()
    .ConfigureAppConfiguration((context, config) =>
    {
        string appConfigUri = Environment.GetEnvironmentVariable("AppConfigEndpoint");
        if (!string.IsNullOrEmpty(appConfigUri))
        {
            config.AddAzureAppConfiguration(options =>
                options.Connect(new Uri(appConfigUri), new ManagedIdentityCredential()));
        }
    })
    .Build();

host.Run();
