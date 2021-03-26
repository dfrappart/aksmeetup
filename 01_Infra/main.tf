######################################################################
# Access to Azure
######################################################################

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

# Creating the Resource Group

module "ResourceGroup" {

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks//003_ResourceGroup/"
  #Module variable      
  RGSuffix                                = var.ResourcesSuffix
  RGLocation                              = var.AzureRegion
  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  EnvironmentTag                          = var.Environment
  Project                                 = var.Project

}

module "AKSSpokeVNet" {
  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Custom_Modules/IaaS_NTW_VNet_for_AppGW/"

  #Module variable
  RGLogName                               = data.azurerm_resource_group.RGLog.name
  LawSubLogName                           = data.azurerm_log_analytics_workspace.LAWLogName.name
  STASubLogName                           = data.azurerm_storage_account.STALogName.name
  TargetRG                                = module.ResourceGroup.RGName
  TargetLocation                          = module.ResourceGroup.RGLocation
  VNetSuffix                              = var.ResourcesSuffix

  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  Environment                             = var.Environment
  Project                                 = var.Project

}


######################################################################
# Module for AKS

module "AKS1" {
  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Custom_Modules/IaaS_AKS_ClusterwithRBAC_Kubenet/"

  #Module variable
  STASubLogId                             = data.azurerm_storage_account.STALogName.id
  LawSubLogId                             = data.azurerm_log_analytics_workspace.LAWLogName.id

  AKSLocation                             = module.ResourceGroup.RGLocation
  AKSRGName                               = module.ResourceGroup.RGName
  AKSSubnetId                             = module.AKSSpokeVNet.FESubnetFullOutput.id
  AKSClusSuffix                           = var.AKSClusSuffix
  PublicSSHKey                            = var.AKSSSHKey
  AKSClusterAdminsIds                     = [var.AKSClusterAdminsIds]
  ACG1Id                                  = var.SubACG
  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  Environment                             = var.Environment
  Project                                 = var.Project

}


######################################################################
# Mapping AKS SAI to VNet

module "AssignAKS_SAI_NTWContributor_To_RGVNet" {

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks/401_RBACAssignment_BuiltinRole/"

  #Module variable
  RBACScope                               = module.ResourceGroup.RGId
  BuiltinRoleName                         = "Network Contributor"
  ObjectId                                = module.AKS1.KubeControlPlane_SAI_PrincipalId

}

######################################################################
# Mapping AKS SAI to subscription - Managed Identity Operator

module "AssignAKS_SAI_ManagedIdentityOps_To_Sub" {

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks/401_RBACAssignment_BuiltinRole/"

  #Module variable
  RBACScope                               = data.azurerm_subscription.current.id
  BuiltinRoleName                         = "Managed Identity Operator"
  ObjectId                                = module.AKS1.KubeControlPlane_SAI_PrincipalId

}

######################################################################
# Mapping AKS SAI to VNet

module "AssignAKS_SAI_VMContributor_To_Sub" {

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks/401_RBACAssignment_BuiltinRole/"

  #Module variable
  RBACScope                               = data.azurerm_subscription.current.id
  BuiltinRoleName                         = "Virtual Machine Contributor"
  ObjectId                                = module.AKS1.KubeControlPlane_SAI_PrincipalId

}

######################################################################
# Mapping AKS Kubelet UAI to VNet

module "AssignAKS_KubeletUAI_NTWContributor_To_RGVNet" {

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks/401_RBACAssignment_BuiltinRole/"

  #Module variable
  RBACScope                               = module.ResourceGroup.RGId
  BuiltinRoleName                         = "Network Contributor"
  ObjectId                                = module.AKS1.FullAKS.kubelet_identity[0].object_id
  #module.AKS1.KubeControlPlane_SAI_PrincipalId

}

######################################################################
# Mapping AKS Kubelet UAI to subscription - Managed Identity Operator

module "AssignAKS_KubeletUAI_ManagedIdentityOps_To_Sub" {

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks/401_RBACAssignment_BuiltinRole/"

  #Module variable
  RBACScope                               = data.azurerm_subscription.current.id
  BuiltinRoleName                         = "Managed Identity Operator"
  ObjectId                                = module.AKS1.FullAKS.kubelet_identity[0].object_id
  #module.AKS1.KubeControlPlane_SAI_PrincipalId

}

######################################################################
# Mapping AKS Kubelet UAI to VM Operator role

module "AssignAKS_KubeletUAI_VMContributor_To_Sub" {

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks/401_RBACAssignment_BuiltinRole/"

  #Module variable
  RBACScope                               = data.azurerm_subscription.current.id
  BuiltinRoleName                         = "Virtual Machine Contributor"
  ObjectId                                = module.AKS1.FullAKS.kubelet_identity[0].object_id
  #module.AKS1.KubeControlPlane_SAI_PrincipalId

}


######################################################################
# Module kv

# Defining a local for kv name and management with sbx

locals {
  KVSuffix = var.Environment != "lab" ? var.ResourcesSuffix : formatdate("MMMDD",timestamp()) #module.kvrandomsuffix.Result
}

module "AKSKeyVault" {

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks/410_Keyvault/"

  #Module variable     
  TargetRG                                = module.ResourceGroup.RGName
  TargetLocation                          = module.ResourceGroup.RGLocation
  KeyVaultTenantID                        = data.azurerm_subscription.current.tenant_id
  STASubLogId                             = data.azurerm_storage_account.STALogName.id
  LawSubLogId                             = data.azurerm_log_analytics_workspace.LAWLogName.id
  KeyVaultSuffix                          = local.KVSuffix
  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  Environment                             = var.Environment
  Project                                 = var.Project


}


module "AKSKeyVaultAccessPolicyTF" {

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks/411_KeyVault_Access_Policy/"

  #Module variable     
  VaultId                                 = module.AKSKeyVault.Id
  KeyVaultTenantId                        = data.azurerm_subscription.current.tenant_id
  KeyVaultAPObjectId                      = data.azurerm_client_config.currentclientconfig.object_id
  Secretperms                             = var.Secretperms_TFApp_AccessPolicy

  depends_on = [
    module.AKSKeyVault,
  ]

}


module "AKSKeyVaultAccessPolicy_ClusterAdmin" {

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks/411_KeyVault_Access_Policy/"

  #Module variable     
  VaultId                                 = module.AKSKeyVault.Id
  KeyVaultTenantId                        = data.azurerm_subscription.current.tenant_id
  KeyVaultAPObjectId                      = var.AKSClusterAdminsIds
  Secretperms                             = var.Secretperms_TFApp_AccessPolicy

  depends_on = [
    module.AKSKeyVault,
  ]

}


module "SecretTest_to_KV" {

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks/412_KeyvaultSecret/"

  #Module variable     
  KeyVaultSecretSuffix                    = var.KeyVaultSecretSuffix
  #PasswordValue                           = module.SecretTest.Result
  KeyVaultId                              = module.AKSKeyVault.Id
  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  Environment                             = var.Environment
  Project                                 = var.Project

  depends_on = [
    module.AKSKeyVault,
    module.AKSKeyVaultAccessPolicyTF
  ]

}


######################################################################
# Creating a test UAI for Kubernetes

module "UAI1" {

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Custom_Modules/Kube_UAI/"

  #Module variable
  UAISuffix                               = var.UAISuffix #"lab1"
  TargetLocation                          = module.ResourceGroup.RGLocation
  TargetRG                                = module.ResourceGroup.RGName
  RBACScope                               = module.ResourceGroup.RGId
  BuiltinRoleName                         = "Reader"
  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  Environment                             = var.Environment
  Project                                 = var.Project


}

resource "local_file" "podidentitymanifest" {
  content                                 = module.UAI1.podidentitymanifest
  filename                                = "../03_PodIdentity_Yaml/PodId/${module.UAI1.Name}.yaml"
}

resource "local_file" "podidentitybindingmanifest" {
  content                                 = module.UAI1.podidentitybindingmanifest
  filename                                = "../03_PodIdentity_Yaml/PodId/${module.UAI1.Name}_Binding.yaml"
}

resource "local_file" "secretprovider1" {
  content                                 = templatefile("./yamltemplate/secretprovider-template.yaml",
    {
      UAIClientId                         = module.UAI1.ClientId
      KVName                              = module.AKSKeyVault.Name
      SecretName                          = module.SecretTest_to_KV.SecretFullOutput.name
      SecretVersion                       = ""
      TenantId                            = data.azurerm_subscription.current.tenant_id
    }
  )
  filename = "../03_PodIdentity_Yaml/SecretStore/${lower(module.AKSKeyVault.Name)}-secretstore.yaml"
}

resource "local_file" "podexample" {
  content                                 = templatefile("./yamltemplate/TestPod-template.yaml",
    {
      UAIName                             = module.UAI1.Name
      KVName                              = module.AKSKeyVault.Name
    }
  )
  filename = "../03_PodIdentity_Yaml/demo-pod.yaml"
}

module "AKSKeyVaultAccessPolicy_UAI1" {

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks/411_KeyVault_Access_Policy/"

  #Module variable     
  VaultId                                 = module.AKSKeyVault.Id
  KeyVaultTenantId                        = data.azurerm_subscription.current.tenant_id
  KeyVaultAPObjectId                      = module.UAI1.PrincipalId
  Secretperms                             = var.Secretperms_UAI1_AccessPolicy

  depends_on = [
    module.AKSKeyVault,
  ]

}

