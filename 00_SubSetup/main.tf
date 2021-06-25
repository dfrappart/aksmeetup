##############################################################
#This file call the modules for the subscription setup
##############################################################

######################################################################
# Access to Azure
######################################################################

terraform {
  
  #backend "azurerm" {}
  required_providers {
    azurerm = {}

  }
}

provider "azurerm" {
  subscription_id                          = var.AzureSubscriptionID
  client_id                                = var.AzureClientID
  client_secret                            = var.AzureClientSecret
  tenant_id                                = var.AzureTenantID

  features {}
  
}

######################################################################
# Module call
######################################################################

###############################################################
#Module creating the storage and log analytics for log

module "BasicLogConfig" {

  #Module Location
  source = "github.com/dfrappart/Terra-AZModuletest//Custom_Modules/00_AzSubLogs/"

  #Module variable
  SubLogSuffix          = var.Project
  ResourceOwnerTag      = var.ResourceOwnerTag
  CountryTag            = var.CountryTag
  CostCenterTag         = var.CostCenterTag
  Project               = var.Project
  Environment           = var.Environment
  Company               = var.Company
  SubId                 = data.azurerm_subscription.current.subscription_id

}


###############################################################
#Module to create Observability

module "ObservabilityConfig" {

  #Module Location
  source = "github.com/dfrappart/Terra-AZModuletest//Custom_Modules/01_ObservabilityBasics/"

  #Module variable
  ASCPricingTier                      = var.ASCPricingTier
  ASCContactMail                      = var.ASCContactMail
  Subid                               = data.azurerm_subscription.current.id
  LawId                               = module.BasicLogConfig.SubLogAnalyticsWSId
  RGLogs                              = module.BasicLogConfig.RGLogName
  SubContactList                      = var.SubContactList
  IsDeploymentTypeGreenField          = var.IsDeploymentTypeGreenField
  #Tags related resources
  Environment                         = var.Environment
  Project                             = var.Project
  CostCenterTag                       = var.CostCenterTag
  CountryTag                          = var.CountryTag
  ResourceOwnerTag                    = var.ResourceOwnerTag

 
}

