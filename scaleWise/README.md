# scaleWise
scaleWise is a serverless Azure solution that automatically right-sizes your cloud resources based on a schedule — helping Dev/Test teams cut costs during off-hours without any manual effort.

Why scaleWise?

Azure lacks a native way to easily "turn down" managed services between service tiers on a schedule
Dev/Test environments often run at full capacity overnight and on weekends — wasting budget
ScaleWise fills that gap with a lightweight, tag-driven automation built entirely on Azure Functions

## How it works:

Engine Function (C#) — runs every 5 minutes, queries Azure Resource Graph for resources tagged with resize-Enable = True, evaluates the configured schedule, and posts scale instructions to a Storage Queue
Scaler-Trigger Function (PowerShell) — listens to the queue and processes each scale request using resource-specific scaler modules

Scaler Modules — pluggable PowerShell modules, one per resource type, that handle the actual scaling API calls
To use ScaleWise, simply tag your Azure resources with the required tags and ScaleWise handles the rest — scaling down during off-hours and restoring the original tier when the window ends.


## Repo Contents

| File/folder       | Description                                |
|-------------------|--------------------------------------------|
| `bicep-templates/`   | ScaleWise Infrastructure bicep Template.      |
| `azure-functions/` | ScaleWise project Azure Functions. Includes Engine and Trigger.|
| `.gitignore`      | Define what to ignore at commit time.      |
| `deploy.ps1`      | PowerShell script to deploy tool.          |
| `README.md`       | This README file.                          |
| `teardown.ps1`    | PowerShell script to decommission the tool. Makes testing and experimentation easy.|


## ScaleWise Architecture and Workflow

<img width="684" height="332" alt="image" src="https://github.com/user-attachments/assets/a6116d1e-b69d-4ab5-a559-f2ec0574f1da" />



## Prerequisites

To successfully deploy this project, it requires the Azure user have the following:

- Azure AD Role allowing user to assign roles (Global Admin, App Admin, Cloud App Admin)
    - *necessary to assign proper scope to managed identity*
- Azure RBAC role of Owner or Contributor at the Subscription scope
- Azure Subscription
- Powershell installed


## Current Supported Azure Services

The list of services currently supported by ScaleWise:
- App Service Plans
- SQL Database
- SQL Elastic Pools
- Virtual Machine (COMING SOON!!!!)


## Deploying ScaleWise

### Steps to deploy infrastructure:

- Clone the GitHub repo down to your local machine
- Run `deploy.ps1` from project root

The deployment script will ask the user to input a unique name for their deployment, as well as their desired Azure region. These will be passed to the script as parameters. 

Example:
```
PS /User/git_repos/github/azure-autoscale> ./deploy.ps1
Enter a unique name for your deployment: tjptest
Enter Azure Region to deploy to: westus
```

### Steps to tear down the deployment:
- Run `teardown.ps1` from project root
    - Script will ask user for a Resource Group Name, and then delete that resource group and all associated resources
    

## Running ScaleWise
ScaleWise is currently configured to run in the context of a single subscription, and relies on the Graph API and certian Tags on resources to handle service tier scaling for you! The Engine will query Graph API every 5 min (by default) and perform a get on resources tagged with `resize-Enable = True`. If resize has been enabled, and times have been configured, the Engine will determine which direction the resource would like to scale and send a message to the storage queue. 

All you need to do to run ScaleWise is deploy the solution and ensure you have the proper tags set, and ScaleWise will take care of the rest! 


## Required Tags for all services
ScaleWise operates based on service tags. Some of the required tags will be common between Azure services, and some tags will be specific to the resource you would like ScaleWise to scale. Resource specific tags will be discussed in detail on that resources page: [Scaler Modules](./docs/scalers/modules/)

ScaleWise Common Tags:
```
resize-Enable = <bool> (True/False)
resize-StartTime = <DateTime> (Friday 7PM)
resize-EndTime = <DateTime> (Monday 7:30AM)
```
_**NOTE: StartTime and EndTime are currently in UTC**_

## ScaleWise Infrastructure

### So, what does this solution actually deploy?

The included deploy script, `deploy.ps1`, will build the following infrastructure:
- **Resource Group** 
    - You _can_ bring an existing resource group
    - Deployment will create a new resource group if one does not already exist
- **System Assigned Managed Identity**
    - Managed Identity for the App Service Plan will have Contributor rights to the Subscription
- **Azure Storage Account**
    - Storage for Azure Function App Files
    - Storage Queue for Function Trigger
- **Azure App Service Plan**
    - Windows App Service Plan to host Powershell Function Apps
        - Scaler Function App
            - Scaler modules
        - Engine Function App
- **Zip Deploy Function Package** 
    - Deploy Function Zip packages to the Function App
- **Azure Application Insights**
    - App Insights for App Service Plan


### Security considerations
For the purpose of this proof of concept we have not integrated security features into ScaleWise as is being deployed through this workflow. This solution is a Proof Of Concept and is not secure, it is only recommended for testing. To use this service in a production deployment it is recommended to review the following documentation from Azure. It walks though best practices on securing Azure Functions: 
[Securing Azure Functions](https://docs.microsoft.com/en-us/azure/azure-functions/security-concepts)

**_IT IS RECOMMENDED TO USE AVAILABLE SECURITY CONTROLS IN A PRODUCTION DEPLOYMENT_**

## FAQ

**Why would I use ScaleWise?**

You realize that by "turning down" your resources in Dev/Test environments you could save a lot of money. You also realize there is not currently an an easy way to scale service tiers on Azure PaaS services. ScaleWise to the rescue!!!! Tag your resources with scale times and desired "simmer" settings and ScaleWise will take care of the rest!

**What does the roadmap for ScaleWise look like?**

We would like this to become a SaaS/PaaS product that will help to keep our customers costs under control in Dev/Test Environments. 

**Who are the awesome people that built this solution??**

Matt, Nills, and Tyler are Cloud Solutions Architects at Microsoft, and are always looking for interesting ways to help our customers solve problems!

**Want to know more about ScaleWise??**

## Contributing

