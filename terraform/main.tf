provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}
module "resource_group" {
  source              = "./modules/resource_group"
  resource_group_name = "my-resource-group"
  location            = "East US"
}