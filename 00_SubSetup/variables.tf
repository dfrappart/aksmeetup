######################################################
# Variables
######################################################

##############################################################
#Variable declaration for provider

variable "AzureSubscriptionID" {
  type                          = string
  description                   = "The subscription id for the authentication in the provider"
}

variable "AzureClientID" {
  type                          = string
  description                   = "The application Id, taken from Azure AD app registration"
}


variable "AzureClientSecret" {
  type                          = string
  description                   = "The Application secret"

}

variable "AzureTenantID" {
  type                          = string
  description                   = "The Azure AD tenant ID"
}


variable "IsDeploymentTypeGreenField" {
  type                        = string
  default                     = true
  description                 = "Describe the type of deployment, can be GreenField or not. If GreenField, means that the subscription setup is not applied on a newly created subscription."


}


###################################################################
#variable declaration az log config

variable "RGLogLocation" {
  type                          = string
  description                   = "Variable defining the region for the log resources"
  default                       = "westeurope"
}

variable "SubLogSuffix" {
  type                          = string
  description                   = "Suffix to add to the resources, by default, log"
  default                       = "log"
}


###################################################################
#Tag related variables and naming convention section

variable "ResourceOwnerTag" {
  type                          = string
  description                   = "Tag describing the owner"
  default                       = "CloudTeam"
}

variable "CountryTag" {
  type                          = string
  description                   = "Tag describing the Country"
  default                       = "fr"
}

variable "CostCenterTag" {
  type                          = string
  description                   = "Tag describing the Cost Center"
  default                       = "subsetup"
}


variable "Company" {
  type                          = string
  description                   = "The Company owner of the resources"
  default                       = "df"
}

variable "Project" {
  type                          = string
  description                   = "The name of the project"
  default                       = "subsetup"
}

variable "Environment" {
  type                          = string
  description                   = "The environment, dev, prod..."
  default                       = "lab"
}




##############################################################
#Variable Observability basics

variable "ASCPricingTier" {
  type          = string
  description   = "The Azure Security Center Pricing Tiers, can be Free or Standard"
  default       = "Free"
}


variable "ASCContactMail" {
  type          = string
  description   = "The Azure Security Center Pricing Tiers, can be Free or Standard"

}

variable "notifySecContact" {
  type          = string
  description   = "Are the Security Contact notified by ASC ? Defualt to True"
  default       = true
}

variable "notifySubAdmins" {
  type          = string
  description   = "Are the Subscription Admins notified by ASC ? Defualt to True"
  default       = true
}

variable "SubContactList" {
  type          = string
  description   = "The contactlist email address for the alerting"


}