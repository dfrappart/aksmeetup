# Azure Automation setup


## Terraform provider configuration


The terraform provider is configured as follow:

```hcl.js

provider "azurerm" {
  subscription_id = var.AzureSubscriptionID1
  client_id       = var.AzureClientID
  client_secret   = var.AzureClientSecret
  tenant_id       = var.AzureTenantID
}

```

Each Terraform config will presents itself with a file named **00_Authentication.tf**

Variable for the provider should be written in a secret file in case of a deployment in a pipeline.

```hcl

variable "AzureSubscriptionID" {
  type    = "string"
  default = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx"
}

variable "AzureClientID" {
  type    = "string"
  default = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxf"
}


variable "AzureClientSecret" {
  type    = "string"
  default = ""

}

variable "AzureTenantID" {
  type    = "string"
  default = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx"
}

```

It is also possible to remove default value and to use a tfvars file or terraform cli configuration to pass the sensible parameters.

For a simple deployment, use the authentication through az cli and comment the tf file




Login to azure, list the available subscription and select the one targeted for the deployment:

```powershell.js

az login -u <userlogin>
az account list --output table
az account set --subscription xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx

```


```hcl.js

provider "azurerm" {
  /*subscription_id = var.AzureSubscriptionID
  client_id       = var.AzureClientID
  client_secret   = var.AzureClientSecret
  tenant_id       = var.AzureTenantID*/
}

```




## Terraform backend configuration

As a best practice, use of remote backend is recommanded for terraform usage.
Azure Storage can be used as such backend.
Specify the azure storage account used as a backend, created previously, with variables value for the authentication in a file to be stored as secret in Azure Devops:


```hcl.js

terraform {
  backend "azurerm" {
    storage_account_name = "The name of the storage account"
    container_name       = "the name of the container"
    key                  = "name of the blob to store the backend"
    access_key           = "storageaccountaccesskey"
  }
}

```


### Prerequisite to use the code

#### Terraform

- Terraform code can be tested locally with only terraform installed on the station.
- Current version is Terraform 0.12.26.
- A app registration or a interactive logon on az cli is required to deploy the resource
- Defining a terraform.tfvars is required, as specified in the file terraform.tfvars.example



## This folder contains the terraform config to deploy the Azure automation resource used to managed the subscription


### 1. List of Azure resources deployed through


|Resources type | Resources usage | Info | naming convention |
|---------------|:---------------:|:----:|------------------:|
|Resource Group | Group Log storage resources | N/A |applicationname-environment-rsg-role-index |
|Resource Group | Group Automation resoources | N/A | applicationname-environment-rsg-role-index |
|Storage account | store the diagnostic log ofr diagnostic enabled resources | Located in the Resource Group for Logs | applicationnameenvironmentstaroleindex |
|Automation account | Allows to run script in runbook for subscription management | Located in the Resource Group for Automation | applicationname-environment-aac-role-index |
|Automation Runbook | This runbook contains a script for ps module update | Located in the Resource Group for Automation | No naming convention required |
|Automation PS Module | A PS Module imported in the automation account. Specifically, the module Az.Accounts | Located in the Resource Group for Automation | No naming convention required |
|Automation Schedule | A resource in Automation account to schedule the monthly execution of the runbook. | Located in the Resource Group for Automation | No naming convention required |
|Automation JobSchedule | A resouce in Automation account to link a schedule and a runbook | Located in the Resource Group for Automation | No naming convention required |


### 2. Terraform configuration deployment - terraform.tfvars


Fill in the terraform.tfvars to input the value of the variables

```hcl.js

######################################################################
# config variables 
######################################################################

#Provider variable

AzureSubscriptionID = ""
AzureClientID       = ""
AzureClientSecret   = ""
AzureTenantID       = ""

#Resource Group related variables

AutomationAccountLocation       = "westeurope"
AutomationAccountRGRole         = "AzAuto"
LogRGRole                       = "Log"

#Storage account diag log variable

STADiaglogRole                  = "diaglogdfr"

#Automation creds related variables
AutoCredsUserName               = "autorunas@teknews.cloud"
AutoCredsPwd                    = ""
#Tags related resources
applicationTag       = "INFR"
costcenterTag        = "INFR"
businessunitTag      = "INFR"
managedbyTag         = "DFITC"
environmentTag       = "DEV"
ownerTag             = "DFR"
roleTag              = "N/A"
createdbyTag         = "Terraform"


```

### 3. Backend configuration

Specify the azure storage account used as a backend, which should have been created with the script configurebackend.ps1, with variables value for the authentication in a file to be stored as secret in Azure Devops:


```hcl.js

terraform {
  backend "azurerm" {
    storage_account_name = "The name of the storage account"
    container_name       = "the name of the container"
    key                  = "name of the blob to store the backend"
    access_key           = "storageaccountaccesskey"
  }
}


```

## Display after provisioning


You should have something looking like that in the Azure portal: 

![Illustration 1](./Img/readme01.png)

![Illustration 1](./Img/readme02.png)

