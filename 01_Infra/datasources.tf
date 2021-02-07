#############################################################################
#This file is used to define data source refering to Azure existing resources
#############################################################################


#############################################################################
#data sources


data "azurerm_subscription" "current" {}

data "azurerm_client_config" "currentclientconfig" {}

data "azurerm_resource_group" "RGLog" {
  name                  = var.RGLogName
}

#Data source for the log storage

data "azurerm_storage_account" "STALogName" {
  name                  = var.STASubLogName
  resource_group_name   = data.azurerm_resource_group.RGLog.name
}

#Data source for the log analytics workspace

data "azurerm_log_analytics_workspace" "LAWLogName" {
  name                  = var.LawSubLogName
  resource_group_name   = data.azurerm_resource_group.RGLog.name
}