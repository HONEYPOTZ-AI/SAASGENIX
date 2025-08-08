
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "saasgenix_rg" {
  name     = "saasgenix-resource-group"
  location = "East US"
}

resource "azurerm_container_registry" "saasgenix_acr" {
  name                = "saasgenixacr"
  resource_group_name = azurerm_resource_group.saasgenix_rg.name
  location            = azurerm_resource_group.saasgenix_rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_kubernetes_cluster" "saasgenix_aks" {
  name                = "saasgenix-aks"
  location            = azurerm_resource_group.saasgenix_rg.location
  resource_group_name = azurerm_resource_group.saasgenix_rg.name
  dns_prefix          = "saasgenix"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "production"
  }
}
