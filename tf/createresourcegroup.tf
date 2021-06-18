#################################
##          Variables           ##
#################################
variable subscription_id {}
variable client_id {}
variable client_secret {}
variable tenant_id {}

#################################
##          Provider           ##
#################################

provider "azurerm" {
    subscription_id = "${var.subscription_id}"
    client_id       = "${var.client_id}"
    client_secret   = "${var.client_secret}"
    tenant_id       = "${var.tenant_id}"
	features {}
}

#terraform {
#  required_providers {
#    azurerm = {
#      source = "hashicorp/azurerm"
#      version = "~>2.26"
#    }
#  }
#}
#provider "azurerm" {
#  features {}
#}



# Create a resource group if it doesn't exist
resource "azurerm_resource_group" "myterraformgroup" {
    name     = "myResourceGroup"
    location = "eastus"

    tags = {
        environment = "Terraform Demo"
    }
}