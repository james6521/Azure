#################################
##          Variables          ##
#################################
variable subscription_id {}
variable client_id {}
variable client_secret {}
variable tenant_id {}
variable resource_name {
 	default="<%=customOptions.resname%>"
}
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
# Create a resource group if it doesn't existname     =  var.resource_name
resource "azurerm_resource_group" "myterraformgroup" {
    name     =  var.resource_name
    location = "eastus"

    tags = {
        environment = "Terraform Demo"
    }
}