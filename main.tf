provider "azurerm" {
  features {}

  subscription_id = "<YOUR SUBSCRIPTION ID>"
  client_id       = "<YOUR CLIENT ID>"
  client_secret   = "<YOUR CLIENT SECRET>"
  tenant_id       = "<YOUR TENANT ID>"
}

resource "azurerm_resource_group" "rg" {
  name     = "aks-resource-group"
  location = "Switzerland North"
}

resource "azurerm_resource_group" "aks_nw_rg" {
  name     = "aks-nwwatcher-resource-group"
  location = "Switzerland North"
}

resource "azurerm_network_watcher" "aks_nw" {
  name                = "aks-nw"
  location            = azurerm_resource_group.aks_nw_rg.location
  resource_group_name = azurerm_resource_group.aks_nw_rg.name
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-cluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aks-example"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }

}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_admin_config_raw
  sensitive = true
}
