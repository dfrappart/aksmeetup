######################################################################
# Webshop K8S + Storage resources
######################################################################

######################################################################
# Access to terraform
######################################################################

terraform {

  #backend "azurerm" {}

  required_providers {
    azurerm = {}
    kubernetes = {}
    helm = {}
  }
}

provider "azurerm" {
  subscription_id         = var.AzureSubscriptionID
  client_id               = var.AzureClientID
  client_secret           = var.AzureClientSecret
  tenant_id               = var.AzureTenantID

  features {}
}


/*
provider "kubernetes" {
  config_path    = var.kubepath
  config_context = var.kubecontext


}


provider "helm" {
  kubernetes {
    config_path = var.kubepath
  }
}

*/

provider "kubernetes" {

  host                    = data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.host #module.AKSClus.KubeAdminCFG_HostName
  username                = data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.username
  password                = data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.password
  client_certificate      = base64decode(data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.client_certificate)
  client_key              = base64decode(data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.client_key)
  cluster_ca_certificate  = base64decode(data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.cluster_ca_certificate)

}


provider "helm" {
  kubernetes {

  host                    = data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.host #module.AKSClus.KubeAdminCFG_HostName
  username                = data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.username
  password                = data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.password
  client_certificate      = base64decode(data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.client_certificate)
  client_key              = base64decode(data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.client_key)
  cluster_ca_certificate  = base64decode(data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.cluster_ca_certificate)

  }
}


locals {

  ResourcePrefix                        = "${lower(var.Company)}${lower(var.CountryTag)}"

}

######################################################################
# installing kured from helm

resource "helm_release" "kured" {
  name                                = "kured"
  repository                          = "https://weaveworks.github.io/kured"
  chart                               = "kured"
  version                             = var.kuredChartVer
  namespace                           = "kured"
  create_namespace                    = true

  dynamic "set" {
    for_each                          = var.HelmKuredParam
    iterator                          = each
    content {
      name                            = each.value.ParamName
      value                           = each.value.ParamValue
    }

  }

  set_sensitive {
    name                              = var.HelmKuredSensitiveParamName
    value                             = var.HelmKuredSensitiveParamValue
  }
}

######################################################################
# installing pod identity from helm

resource "helm_release" "podidentity" {
  name                                = "podidentity"
  repository                          = "https://raw.githubusercontent.com/Azure/aad-pod-identity/master/charts"
  chart                               = "aad-pod-identity"
  version                             = var.PodIdChartVer
  namespace                           = "podid"
  create_namespace                    = true


  dynamic "set" {
    for_each                          = var.HelmPodIdentityParam
    iterator                          = each
    content {
      name                            = each.value.ParamName
      value                           = each.value.ParamValue
    }

  }


}