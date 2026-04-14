provider "azurerm"{
  features {
    
  }
  subscription_id = var.subscription_id
}
module "resource_group" {
  source              = "./modules/resource_group"
  resource_group_name = var.resource_group_name
  vm_name = var.vm_name
  location            = "East US"
}