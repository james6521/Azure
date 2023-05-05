#################################
##          Variables          ##
#################################
variable subscription_id {}
variable client_id {}
variable client_secret {}
variable tenant_id {}
##variable "resource_name" {
##	description ="Resource Name"
##	default=""
##}
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
# Create a resource group if it doesn't exist
resource "azurerm_resource_group" "myterraformgroup" {
    name     = "jamestest"
    location = "eastus"

    tags = {
        environment = "Terraform Demo"
    }
}