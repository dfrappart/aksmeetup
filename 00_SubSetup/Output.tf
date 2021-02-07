######################################################
# This file defines which value are sent to output
######################################################




######################################################
# Output from RBAC Basic config
/*
# Contributor assignment

output "ContributorRoleResourceId" {
  value                   = module.AssignContributorRoleToSubscription.RoleResourceId
  sensitive               = true
}

output "ContributorRolePrincipalType" {
  value                   = module.AssignContributorRoleToSubscription.RolePrincipalType
}

output "ContributorRoleScope" {
  value                   = module.AssignContributorRoleToSubscription.RoleScope
  sensitive               = true
}

output "ContributorRoleId" {
  value                   = module.AssignContributorRoleToSubscription.RoleId
  sensitive               = true
}

output "ContributorRoleName" {
  value                   = module.AssignContributorRoleToSubscription.RoleName
    
}

# Reader assignment

output "ReaderRoleResourceId" {
  value                   = module.AssignReaderRoleToSubscription.RoleResourceId
  sensitive               = true
}

output "ReaderRolePrincipalType" {
  value                   = module.AssignReaderRoleToSubscription.RolePrincipalType
    
}

output "ReaderRoleScope" {
  value                   = module.AssignReaderRoleToSubscription.RoleScope
  sensitive               = true
}

output "ReaderRoleId" {
  value                   = module.AssignReaderRoleToSubscription.RoleId
  sensitive               = true
}

output "ReaderRoleName" {
  value                   = module.AssignReaderRoleToSubscription.RoleName
  
}
*/


###################################################################
# Outputs for Az subscription logging config module

###################################################################
# Outputs for RG

output "RGLogName" {

  value                   = module.BasicLogConfig.RGLogName
}

output "RGLogLocation" {

  value                   = module.BasicLogConfig.RGLogLocation
}

output "RGLogId" {

  value                   = module.BasicLogConfig.RGLogId
  sensitive               = true
}

###################################################################
#Output for the log storage account

output "STALogName" {
  value                   = module.BasicLogConfig.STALogName
}

output "STALogId" {
  value                   = module.BasicLogConfig.STALogId
  sensitive               = true
}

output "STALogPrimaryBlobEP" {
  value                   = module.BasicLogConfig.STALogPrimaryBlobEP
  sensitive               = true
}

output "STALogPrimaryQueueEP" {
  value                   = module.BasicLogConfig.STALogPrimaryQueueEP
  sensitive               = true
}

output "STALogPrimaryTableEP" {
  value                   = module.BasicLogConfig.STALogPrimaryTableEP
  sensitive               = true
}

output "STALogPrimaryFileEP" {
  value                   = module.BasicLogConfig.STALogPrimaryFileEP
  sensitive               = true
}

output "STALogPrimaryAccessKey" {
  value                   = module.BasicLogConfig.STALogPrimaryAccessKey
  sensitive               = true
}

output "STALogSecondaryAccessKey" {
  value                   = module.BasicLogConfig.STALogSecondaryAccessKey
  sensitive               = true
}

output "STALogConnectionURI" {
  value                   = module.BasicLogConfig.STALogConnectionURI
  sensitive               = true
}

###################################################################
#Output for the log analytics workspace

output "SubLogAnalyticsWSId" {
  value                   = module.BasicLogConfig.SubLogAnalyticsWSId
  sensitive               = true
}

output "SubLogAnalyticsWS_WSId" {
  value                   = module.BasicLogConfig.SubLogAnalyticsWS_WSId
  sensitive               = true
}

output "SubLogAnalyticsWS_Retention" {
  value                   = module.BasicLogConfig.SubLogAnalyticsWS_Retention
  
}

output "SubLogAnalyticsWS_PrimaryAccessKey" {
  value = module.BasicLogConfig.SubLogAnalyticsWS_PrimaryAccessKey
  sensitive               = true 
}

output "SubLogAnalyticsWS_SecondaryAccessKey" {
  value                   = module.BasicLogConfig.SubLogAnalyticsWS_SecondaryAccessKey
  sensitive               = true  
}

output "SubLogAnalyticsWS_PortalURL" {
  value                   = module.BasicLogConfig.SubLogAnalyticsWS_PortalURL
  sensitive               = true  
}





##############################################################
#observability basics outputs
##############################################################

output "DeploymentType" {

  value                   = module.ObservabilityConfig.DeploymentType
}

##############################################################
#Output NetworkWatcher


output "NetworkWatcherName" {

  value                   = module.ObservabilityConfig.NetworkWatcherName

}

output "NetworkWatcherId" {

  value                   = module.ObservabilityConfig.NetworkWatcherId
  sensitive               = true
}

output "NetworkWatcherRGName" {

  value                   = module.ObservabilityConfig.NetworkWatcherRGName
}

##############################################################
#Azure Security Center Output

output "ASCTier" {

  value                   = module.ObservabilityConfig.ASCTier
}

output "ASCId" {

  value                   = module.ObservabilityConfig.ASCId
  sensitive               = true
}
/*
output "ASCContact" {

  value                   = module.ObservabilityConfig.ASCContact
}
*/
##############################################################
#Action Group Output

output "DefaultSubActionGroupId" {

  value                   = module.ObservabilityConfig.DefaultSubActionGroupId
  sensitive               = true
}

output "DefaultSubActionGroupName" {

  value                   = module.ObservabilityConfig.DefaultSubActionGroupName
}

output "DefaultSubActionGroupEmailReceiver" {

  value                   = module.ObservabilityConfig.DefaultSubActionGroupEmailReceiver
}

##############################################################
#Service health Alerts Output

output "ServiceHealthAlertName" {

  value                   = module.ObservabilityConfig.ServiceHealthAlertName
}

output "ServiceHealthAlertId" {

  value                   = module.ObservabilityConfig.ServiceHealthAlertId
  sensitive               = true

}

output "ServiceHealthAlertCriteria" {

  value                   = module.ObservabilityConfig.ServiceHealthAlertCriteria
}

##############################################################
#Resources health Alerts Output

output "ResourcesHealthAlertName" {

  value                   = module.ObservabilityConfig.ResourcesHealthAlertName
}

output "ResourcesHealthAlertId" {

  value                   = module.ObservabilityConfig.ResourcesHealthAlertId
  sensitive               = true
}

output "ResourcesHealthAlertCriteria" {

  value                   = module.ObservabilityConfig.ResourcesHealthAlertCriteria
}