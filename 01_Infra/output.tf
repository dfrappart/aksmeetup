######################################################
#Resource Group ouputs

output "RGName" {

  value             = module.ResourceGroup.RGName
}

output "RGLocation" {

  value             = module.ResourceGroup.RGLocation
}

output "RGId" {

  value             = module.ResourceGroup.RGId
  sensitive         = true
}

######################################################
# Module VNet Outputs
######################################################

##############################################################
#Output for the storage account log

output "STALogsFullOutput" {
  value             = module.AKSSpokeVNet.STALogsFullOutput
  sensitive         = true
}


##############################################################
#Output Log analytics workspace

output "LAWFullOutput" {
  value             = module.AKSSpokeVNet.LAWFullOutput
  sensitive         = true
}


##############################################################
#Output for the VNet

output "VNetFullOutput" {
  value             = module.AKSSpokeVNet.VNetFullOutput
  sensitive         = true
}

##############################################################
# Subnet outputs

# Subnet Bastion

output "AzureBastionSubnetFullOutput" {
  value             = module.AKSSpokeVNet.AzureBastionSubnetFullOutput
  sensitive         = true
}

# Subnet AppGW

output "AGWSubnetFullOutput" {
  value             = module.AKSSpokeVNet.AGWSubnetFullOutput
  sensitive         = true
}

# Subnet FESubnet

output "FESubnetFullOutput" {
  value             = module.AKSSpokeVNet.FESubnetFullOutput
  sensitive         = true
}

# Subnet BESubnet

output "BESubnetFullOutput" {
  value             = module.AKSSpokeVNet.BESubnetFullOutput
  sensitive         = true
}

##############################################################
#Outout for NSG

# NSG Bastion Subnet

output "AzureBastionNSGFullOutput" {
  value             = module.AKSSpokeVNet.AzureBastionNSGFullOutput
  sensitive         = true
}

# NSG AppGW Subnet

output "AGWSubnetNSGFullOutput" {
  value             = module.AKSSpokeVNet.AGWSubnetNSGFullOutput
  sensitive         = true
}

# NSG FE Subnet

output "FESubnetNSGFullOutput" {
  value             = module.AKSSpokeVNet.FESubnetNSGFullOutput
  sensitive         = true
}

# NSG BE Subnet

output "BESubnetNSGFullOutput" {
  value             = module.AKSSpokeVNet.BESubnetNSGFullOutput
  sensitive         = true
}

######################################################
#NSG Rules outputs

output "Default_FESubnet_AllowRDPSSHFromBastionFullOutput" {
  value             = module.AKSSpokeVNet.Default_FESubnet_AllowRDPSSHFromBastionFullOutput
  sensitive         = true
}

output "Default_FESubnet_AllowLBFullOutput" {
  value             = module.AKSSpokeVNet.Default_FESubnet_AllowLBFullOutput
  sensitive         = true
}

output "Default_FESubnet_DenyVNetSSHRDPInFullOutput" {
  value             = module.AKSSpokeVNet.Default_FESubnet_DenyVNetSSHRDPInFullOutput
  sensitive         = true
}

output "Default_BESubnet_AllowRDPSSHFromBastionFullOutput" {
  value             = module.AKSSpokeVNet.Default_BESubnet_AllowRDPSSHFromBastionFullOutput
  sensitive         = true
}

output "Default_BESubnet_AllowLBFullOutput" {
  value             = module.AKSSpokeVNet.Default_BESubnet_AllowRDPSSHFromBastionFullOutput
  sensitive         = true
}

output "Default_AppGWSubnet_GatewayManagerFullOutput" {
  value             = module.AKSSpokeVNet.Default_AppGWSubnet_GatewayManagerFullOutput
  sensitive         = true
}

output "Default_BastionSubnet_AllowHTTPSBastionInFullOutput" {
  value             = module.AKSSpokeVNet.Default_BastionSubnet_AllowHTTPSBastionInFullOutput
  sensitive         = true
}

output "Default_BastionSubnet_AllowGatewayManagerFullOutput" {
  value             = module.AKSSpokeVNet.Default_BastionSubnet_AllowGatewayManagerFullOutput
  sensitive         = true
}

output "Default_BastionSubnet_AllowRemoteBastionOutFullOutput" {
  value             = module.AKSSpokeVNet.Default_BastionSubnet_AllowRemoteBastionOutFullOutput
  sensitive         = true
}

output "Default_AllowAzureCloudHTTPSOutOutFullOutput" {
  value             = module.AKSSpokeVNet.Default_AllowAzureCloudHTTPSOutOutFullOutput
  sensitive         = true
}

output "Default_BastionSubnet_DenyVNetOutFullOutput" {
  value             = module.AKSSpokeVNet.Default_BastionSubnet_DenyVNetOutFullOutput
  sensitive         = true
}

output "Default_BastionSubnet_DenyInternetOutFullOutput" {
  value             = module.AKSSpokeVNet.Default_BastionSubnet_DenyInternetOutFullOutput
  sensitive         = true
}


##############################################################
#Output for Diagnostic logs

output "AzureBastionNSGDiagFullOutput" {
  value             = module.AKSSpokeVNet.AzureBastionNSGDiagFullOutput
  sensitive         = true
}

# NSG AppGW Subnet

output "AppGWSubnetNSGDiagFullOutput" {
  value             = module.AKSSpokeVNet.AppGWSubnetNSGDiagFullOutput
  sensitive         = true
}

# NSG FE Subnet

output "FESubnetNSGDiagFullOutput" {
  value             = module.AKSSpokeVNet.FESubnetNSGDiagFullOutput
  sensitive         = true
}


# NSG BE Subnet

output "BESubnetNSGDiagFullOutput" {
  value             = module.AKSSpokeVNet.BESubnetNSGDiagFullOutput
  sensitive         = true
}

##############################################################
#Output for Flowlogs

output "AzureBastionNSGFlowLogFullOutput" {
  value             = module.AKSSpokeVNet.AzureBastionNSGFlowLogFullOutput
  sensitive         = true
}

# NSG AppGW Subnet

output "AppGWSubnetNSGFlowLogFullOutput" {
  value             = module.AKSSpokeVNet.AppGWSubnetNSGFlowLogFullOutput
  sensitive         = true
}

# NSG FE Subnet

output "FESubnetNSGFlowLogFullOutput" {
  value             = module.AKSSpokeVNet.FESubnetNSGFlowLogFullOutput
  sensitive         = true
}

# NSG BE Subnet

output "BESubnetNSGFlowLogFullOutput" {
  value             = module.AKSSpokeVNet.BESubnetNSGFlowLogFullOutput
  sensitive         = true
}

##############################################################
#Output for Bastion Host

output "SpokeBastionFullOutput" {
  value             = module.AKSSpokeVNet.SpokeBastionFullOutput
  sensitive         = true
}



######################################################
# Output for the AKS module with RBAC enabled

output "KubeName" {
  value             = module.AKS1.KubeName
}

output "KubeLocation" {
  value             = module.AKS1.KubeLocation
}

output "KubeRG" {
  value             = module.AKS1.KubeRG
}

output "KubeVersion" {
  value             = module.AKS1.KubeVersion
}


output "KubeId" {
  value             = module.AKS1.KubeId
  sensitive         = true       
}


output "KubeFQDN" {
  value             = module.AKS1.KubeFQDN
}

output "KubeAdminCFGRaw" {
  value             = module.AKS1.KubeAdminCFGRaw
  sensitive         = true
}


output "KubeAdminCFG" {
  value             = module.AKS1.KubeAdminCFG
  sensitive         = true
}

output "KubeAdminCFG_UserName" {
  value             = module.AKS1.KubeAdminCFG_UserName
  sensitive         = true
}

output "KubeAdminCFG_HostName" {
  value             = module.AKS1.KubeAdminCFG_HostName
  sensitive         = true
}


output "KubeAdminCFG_Password" {
  sensitive         = true
  value             = module.AKS1.KubeAdminCFG_Password
}


output "KubeAdminCFG_ClientKey" {
  sensitive         = true
  value             = module.AKS1.KubeAdminCFG_ClientKey
}


output "KubeAdminCFG_ClientCertificate" {
  sensitive         = true
  value             = module.AKS1.KubeAdminCFG_ClientCertificate
}

output "KubeAdminCFG_ClusCACert" {
  sensitive         = true
  value             = module.AKS1.KubeAdminCFG_ClusCACert
}


output "KubeControlPlane_SAI" {
  sensitive         = true
  value             = module.AKS1.KubeControlPlane_SAI
}

output "KubeControlPlane_SAI_PrincipalId" {
  sensitive         = true
  value             = module.AKS1.KubeControlPlane_SAI_PrincipalId
}

output "KubeControlPlane_SAI_TenantId" {
  sensitive         = true
  value             = module.AKS1.KubeControlPlane_SAI_TenantId
}

output "KubeKubelet_UAI" {
  sensitive         = true
  value             = module.AKS1.KubeKubelet_UAI
}

output "KubeKubelet_UAI_ClientId" {
  sensitive         = true
  value             = module.AKS1.KubeKubelet_UAI_ClientId
}

output "KubeKubelet_UAI_ObjectId" {
  sensitive         = true
  value             = module.AKS1.KubeKubelet_UAI_ObjectId
}

output "KubeKubelet_UAI_Id" {
  sensitive         = true
  value             = module.AKS1.KubeKubelet_UAI_Id
}



######################################################################
# Key Vault Output

output "AKSKeyVault_FullKVOutput" {
  value             = module.AKSKeyVault.FullKVOutput
  sensitive         = true
}

output "AKSKeyVault_Id" {
  value             = module.AKSKeyVault.Id
  sensitive         = true
}

output "AKSKeyVault_Name" {
  value             = module.AKSKeyVault.Name
  sensitive         = false

}

output "AKSKeyVault_Location" {
  value             = module.AKSKeyVault.Location
  sensitive         = false

}

output "AKSKeyVault_RG" {
  value             = module.AKSKeyVault.RG
  sensitive         = false

}

output "AKSKeyVault_SKU" {
  value             = module.AKSKeyVault.SKU
  sensitive         = false
}

output "AKSKeyVault_TenantId" {
  value             = module.AKSKeyVault.TenantId
  sensitive         = true
}

output "AKSKeyVault_URI" {
  value             = module.AKSKeyVault.URI
  sensitive         = true
}


output "AKSKeyVault_KeyVault_enabled_for_disk_encryption" {
  value             = module.AKSKeyVault.KeyVault_enabled_for_disk_encryption
  sensitive         = false
}

output "AKSKeyVault_KeyVault_enabled_for_template_deployment" {
  value             = module.AKSKeyVault.KeyVault_enabled_for_template_deployment
  sensitive         = false
}

######################################################################
# Key Vault Access Policy

output "AKSKeyVaultAccessPolicyTF_Id" {
  value             = module.AKSKeyVaultAccessPolicyTF.Id
  sensitive         = true
}

output "AKSKeyVaultAccessPolicyTF_KeyVaultId" {
  value             = module.AKSKeyVaultAccessPolicyTF.KeyVaultId
  sensitive         = true
}

output "AKSKeyVaultAccessPolicyTF_KeyVaultAcccessPolicyFullOutput" {
  value             = module.AKSKeyVaultAccessPolicyTF.KeyVaultAcccessPolicyFullOutput
  sensitive         = true
}

output "AKSKeyVaultAccessPolicy_ClusterAdmin_Id" {
  value             = module.AKSKeyVaultAccessPolicy_ClusterAdmin.Id
  sensitive         = true
}

output "AKSKeyVaultAccessPolicy_ClusterAdmin_KeyVaultId" {
  value             = module.AKSKeyVaultAccessPolicy_ClusterAdmin.KeyVaultId
  sensitive         = true
}

output "AKSKeyVaultAccessPolicy_ClusterAdmin_KeyVaultAcccessPolicyFullOutput" {
  value             = module.AKSKeyVaultAccessPolicy_ClusterAdmin.KeyVaultAcccessPolicyFullOutput
  sensitive         = true
}

######################################################################
# Random PWD Result

output "RandomPWD_Result" {

  value             = module.SecretTest.Result
  sensitive         = true 

}

######################################################################
# KV Secret module output

output "SecretTest_Id" {
  value             = module.SecretTest_to_KV.Id
  sensitive         = true 
}

output "SecretTest_Version" {
  value             = module.SecretTest_to_KV.Version
  sensitive         = true 
}

output "SecretTest_Name" {
  value             = module.SecretTest_to_KV.Name
  sensitive         = true 
}

output "SecretTest_FullOutput" {
  value             = module.SecretTest_to_KV.SecretFullOutput
  sensitive         = true 
}

/*
######################################################################
# UAI Output

output "UAI1_FullOutput" {
  value                 = module.UAI1.FullUAIOutput
  sensitive             = true
}
output "UAI1_Id" {
  value                 = module.UAI1.Id
  sensitive             = true
}

output "UAI1_Name" {
  value                 = module.UAI1.Name
  sensitive             = false
}

output "UAI1_Location" {
  value                 = module.UAI1.Location
  sensitive             = false
}

output "UAI1_RG" {
  value                 = module.UAI1.RG
  sensitive             = false 
}

output "UAI1_PrincipalId" {
  value                 = module.UAI1.PrincipalId
  sensitive             = true

}

output "UAI1_ClientId" {
  value                 = module.UAI1.ClientId
  sensitive             = true

}

######################################################################
# RBAC Assignment Output

output "Test_RBACAssignmentFull" {
  value           = module.AssignUAI_Test.RBACAssignmentFull
  sensitive       = true
}
output "Test_RBACAssignmentGuid" {
  value           = module.AssignUAI_Test.RBACAssignmentGuid
}

output "Test_RBACAssignmentScope" {
  value           = module.AssignUAI_Test.RBACAssignmentScope
}

output "Test_RBACAssignmentRoleName" {
  value           = module.AssignUAI_Test.RBACAssignmentRoleName
}

output "Test_RBACAssignmentPrincipalId" {
  value           = module.AssignUAI_Test.RBACAssignmentPrincipalId
  sensitive       = true
}

output "Test_RBACAssignmentId" {
  value           = module.AssignUAI_Test.RBACAssignmentId
}

output "Test_RBACAssignmentPrincipalType" {
  value           = module.AssignUAI_Test.RBACAssignmentPrincipalType
}

*/

######################################################################
# Output for the UAI that will be used in kubernetes
######################################################################


# Module Output

output "UAI1_FullUAIOutput" {
  value                 = module.UAI1.FullUAIOutput
  sensitive             = true
}
output "UAI1_Id" {
  value                 = module.UAI1.Id
  sensitive             = true
}

output "UAI1_Name" {
  value                 = module.UAI1.Name
  sensitive             = false
}

output "UAI1_Location" {
  value                 = module.UAI1.Location
  sensitive             = false
}

output "UAI1_RG" {
  value                 = module.UAI1.RG
  sensitive             = false 
}

output "UAI1_PrincipalId" {
  value                 = module.UAI1.PrincipalId
  sensitive             = true

}

output "UAI1_ClientId" {
  value                 = module.UAI1.ClientId
  sensitive             = true

}

output "UAI1_RBACAssignmentFull" {
  value           = module.UAI1.RBACAssignmentFull
  sensitive       = true
}
output "UAI1_RBACAssignmentGuid" {
  value           = module.UAI1.RBACAssignmentGuid
}

output "UAI1_RBACAssignmentScope" {
  value           = module.UAI1.RBACAssignmentScope
}

output "UAI1_RBACAssignmentRoleName" {
  value           = module.UAI1.RBACAssignmentRoleName
}

output "UAI1_RBACAssignmentPrincipalId" {
  value           = module.UAI1.RBACAssignmentPrincipalId
  sensitive       = true
}

output "UAI1_RBACAssignmentId" {
  value           = module.UAI1.RBACAssignmentId
}

output "UAI1_RBACAssignmentPrincipalType" {
  value           = module.UAI1.RBACAssignmentPrincipalType
}

######################################################################
# Output yaml files for kube resources
######################################################################

output "UAI1_podidentitymanifest" {
  value           = module.UAI1.podidentitymanifest
  sensitive       = true
}

output "UAI1_podidentitybindingmanifest" {
  value           = module.UAI1.podidentitybindingmanifest
  sensitive       = true
}

######################################################################
# Key Vault Access Policy for UAI

output "AKSKeyVaultAccessPolicy_UAI1_Id" {
  value             = module.AKSKeyVaultAccessPolicy_UAI1.Id
  sensitive         = true
}

output "AKSKeyVaultAccessPolicy_UAI1_KeyVaultId" {
  value             = module.AKSKeyVaultAccessPolicy_UAI1.KeyVaultId
  sensitive         = true
}

output "AKSKeyVaultAccessPolicy_UAI1_KeyVaultAcccessPolicyFullOutput" {
  value             = module.AKSKeyVaultAccessPolicy_UAI1.KeyVaultAcccessPolicyFullOutput
  sensitive         = true
}
