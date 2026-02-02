<#
.SYNOPSIS
    Collects Windows machine information and uploads to Azure Storage Account

.DESCRIPTION
    This script collects detailed system information from a Windows machine,
    creates a JSON file named with the machine name and date, and uploads it
    to an Azure Storage Account. Designed for deployment via Intune.

.NOTES
    Author: Generated for Intune Deployment
    Date: January 29, 2026

    Requires: Az.Storage module or Azure Storage REST API access

    .\Collect-MachineInfo.ps1 -StorageAccountName "stdeviceinfo" -ContainerName "machine-inventory" -SasToken "sp=racw&st=2026-01-29T17:02:28Z&se=2026-01-30T01:17:28Z&spr=htt"
#>



[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$StorageAccountName,
    
    [Parameter(Mandatory = $true)]
    [string]$ContainerName,
    
    [Parameter(Mandatory = $true)]
    [string]$SasToken  # Provide SAS token with write permissions
)

# Function to collect system information
function Get-SystemInformation {
    try {
        Write-Host "Collecting system information..." -ForegroundColor Cyan
        
        # Get computer system information
        $computerSystem = Get-CimInstance -ClassName Win32_ComputerSystem
        $os = Get-CimInstance -ClassName Win32_OperatingSystem
        $bios = Get-CimInstance -ClassName Win32_BIOS
        $processor = Get-CimInstance -ClassName Win32_Processor | Select-Object -First 1
        $disk = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DeviceID='C:'"
        $networkAdapters = Get-CimInstance -ClassName Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true }
        
        # Get additional details
        $lastBoot = $os.LastBootUpTime
        $installDate = $os.InstallDate
        $uptime = (Get-Date) - $lastBoot
        
        # Get Windows version details
        $winVersion = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion"
        
        # Build the system information object
        $systemInfo = [PSCustomObject]@{
            # General Information
            ComputerName = $env:COMPUTERNAME
            Domain = $computerSystem.Domain
            Manufacturer = $computerSystem.Manufacturer
            Model = $computerSystem.Model
            Chassis = $computerSystem.PCSystemType
            User = $env:USERNAME
            UserDomain = $env:USERDOMAIN
            
            # Operating System
            OSName = $os.Caption
            OSVersion = $os.Version
            OSBuild = $winVersion.CurrentBuild
            OSArchitecture = $os.OSArchitecture
            ServicePack = $os.ServicePackMajorVersion
            InstallDate = $installDate.ToString("yyyy-MM-dd HH:mm:ss")
            LastBoot = $lastBoot.ToString("yyyy-MM-dd HH:mm:ss")
            Uptime = "$($uptime.Days) days, $($uptime.Hours) hours, $($uptime.Minutes) minutes"
            
            # BIOS Information
            BIOSManufacturer = $bios.Manufacturer
            BIOSVersion = $bios.SMBIOSBIOSVersion
            SerialNumber = $bios.SerialNumber
            
            # Hardware
            Processor = $processor.Name
            ProcessorCores = $processor.NumberOfCores
            ProcessorLogicalProcessors = $processor.NumberOfLogicalProcessors
            TotalPhysicalMemoryGB = [math]::Round($computerSystem.TotalPhysicalMemory / 1GB, 2)
            TotalDiskSpaceGB = [math]::Round($disk.Size / 1GB, 2)
            FreeDiskSpaceGB = [math]::Round($disk.FreeSpace / 1GB, 2)
            UsedDiskSpaceGB = [math]::Round(($disk.Size - $disk.FreeSpace) / 1GB, 2)
            
            # Network Information
            NetworkAdapters = @($networkAdapters | ForEach-Object {
                [PSCustomObject]@{
                    Description = $_.Description
                    MACAddress = $_.MACAddress
                    IPAddress = ($_.IPAddress -join ", ")
                    SubnetMask = ($_.IPSubnet -join ", ")
                    DefaultGateway = ($_.DefaultIPGateway -join ", ")
                    DHCPEnabled = $_.DHCPEnabled
                    DNSServers = ($_.DNSServerSearchOrder -join ", ")
                }
            })
            
            # Collection Metadata
            CollectionDate = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
            ScriptVersion = "1.0"
        }
        
        return $systemInfo
    }
    catch {
        Write-Error "Error collecting system information: $_"
        throw
    }
}

# Function to upload to Azure Storage using REST API
function Upload-ToAzureStorage {
    param(
        [Parameter(Mandatory = $true)]
        [string]$FilePath,
        
        [Parameter(Mandatory = $true)]
        [string]$StorageAccountName,
        
        [Parameter(Mandatory = $true)]
        [string]$ContainerName,
        
        [Parameter(Mandatory = $true)]
        [string]$BlobName,
        
        [Parameter(Mandatory = $true)]
        [string]$SasToken
    )
    
    try {
        Write-Host "Uploading file to Azure Storage..." -ForegroundColor Cyan
        
        # Ensure SAS token starts with ?
        if (-not $SasToken.StartsWith("?")) {
            $SasToken = "?$SasToken"
        }
        
        # Read file content as bytes
        $fileBytes = [System.IO.File]::ReadAllBytes($FilePath)
        
        # Construct the blob URL - ensure proper encoding
        $blobUrl = "https://$StorageAccountName.blob.core.windows.net/$ContainerName/$BlobName$SasToken"
        
        Write-Host "Upload URL: https://$StorageAccountName.blob.core.windows.net/$ContainerName/$BlobName" -ForegroundColor Gray
        
        # Prepare headers with required Azure Storage headers
        $headers = @{
            "x-ms-blob-type" = "BlockBlob"
            "x-ms-version" = "2024-11-04"
            "Content-Type" = "application/json; charset=utf-8"
        }
        
        # Upload using REST API with proper error handling
        $response = Invoke-WebRequest -Uri $blobUrl `
                                       -Method Put `
                                       -Headers $headers `
                                       -Body $fileBytes `
                                       -ContentType "application/json; charset=utf-8" `
                                       -UseBasicParsing
        
        if ($response.StatusCode -eq 201 -or $response.StatusCode -eq 200) {
            Write-Host "Successfully uploaded to Azure Storage: $BlobName" -ForegroundColor Green
            return $true
        }
        else {
            Write-Warning "Unexpected status code: $($response.StatusCode)"
            return $false
        }
    }
    catch {
        Write-Error "Error uploading to Azure Storage: $_"
        if ($_.Exception.Response) {
            $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
            $reader.BaseStream.Position = 0
            $responseBody = $reader.ReadToEnd()
            Write-Error "Response: $responseBody"
        }
        Write-Error $_.Exception.Message
        return $false
    }
}

# Main script execution
try {
    Write-Host "========================================" -ForegroundColor Yellow
    Write-Host "Windows Machine Info Collection Script" -ForegroundColor Yellow
    Write-Host "========================================" -ForegroundColor Yellow
    Write-Host ""
    
    # Collect system information
    $systemInfo = Get-SystemInformation
    
    # Create filename with machine name and date
    $date = Get-Date -Format "yyyyMMdd-HHmmss"
    $fileName = "$($env:COMPUTERNAME)_$date.json"
    $localPath = Join-Path -Path $env:TEMP -ChildPath $fileName
    
    Write-Host "Creating JSON file: $fileName" -ForegroundColor Cyan
    
    # Convert to JSON and save locally
    $jsonContent = $systemInfo | ConvertTo-Json -Depth 10
    $jsonContent | Out-File -FilePath $localPath -Encoding UTF8 -Force
    
    Write-Host "JSON file created at: $localPath" -ForegroundColor Green
    Write-Host ""
    
    # Upload to Azure Storage
    $uploadSuccess = Upload-ToAzureStorage -FilePath $localPath `
                                          -StorageAccountName $StorageAccountName `
                                          -ContainerName $ContainerName `
                                          -BlobName $fileName `
                                          -SasToken $SasToken
    
    if ($uploadSuccess) {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Green
        Write-Host "Process completed successfully!" -ForegroundColor Green
        Write-Host "========================================" -ForegroundColor Green
        
        # Optionally clean up local file
        # Remove-Item -Path $localPath -Force
    }
    else {
        Write-Host "Upload failed. Local file retained at: $localPath" -ForegroundColor Yellow
        exit 1
    }
}
catch {
    Write-Error "Script execution failed: $_"
    exit 1
}
