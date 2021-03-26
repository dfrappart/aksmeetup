#############################################################################
#This file is used to define data source refering to Azure existing resources
#############################################################################

#############################################################################
#data source for the subscription setup logs features


#Data source for remote state

data "terraform_remote_state" "AKSClus1" {
  backend   = "azurerm"
  config    = {
    storage_account_name = var.statestoa
    container_name       = var.statecontainer
    key                  = var.statekeyAKSClus1State
    access_key           = var.statestoakey
  }
}

data "azurerm_kubernetes_cluster" "AKSCluster" {
  name                   = data.terraform_remote_state.AKSClus1.outputs.KubeName
  resource_group_name    = data.terraform_remote_state.AKSClus1.outputs.KubeRG

}


/*
data "azurerm_network_security_group" "agwnsg" {
  name                   = data.terraform_remote_state.AKSClus1.outputs.AGWSubnetNSGName
  resource_group_name    = data.terraform_remote_state.AKSClus1.outputs.RGName
}

data "azurerm_network_security_group" "bensg" {
  name                   = data.terraform_remote_state.AKSClus1.outputs.BESubnetNSGName
  resource_group_name    = data.terraform_remote_state.AKSClus1.outputs.RGName
}
*/