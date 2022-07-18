#################################
##          Variables          ##
#################################
variable subscription_id {}
variable client_id {}
variable client_secret {}
variable tenant_id {}
variable vm_name {default="<%=customOptions.vmName%>"}
variable rsg_name{default="<%=customOptions.resname%>"}
variable region_code {default="<%=group.code%>"}
variable instance_name {default="<%=instance.name%>"}
##variable nic_name {default="<%=customOptions.azusrenicname%>"}
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


variable "subnet_id" {
  description = "Subnet Resource ID."
default = "/subscriptions/2e78744c-ede2-4e8d-b4ec-f4c63fff5eb5/resourceGroups/CSM1KAPPRSGN01/providers/Microsoft.Network/virtualNetworks/CSM1KAPPVNT001/subnets/MorpheusPocSubnet"
}
variable "vm_size" {
  description = "VM Size."
default = "Standard_D2s_v3"
}
variable "vm_publisher" {
  description = "VM OS Publisher."
default = "Canonical"
}
variable "vm_offer" {
  description = "VM OS Offer."
default = "UbuntuServer"
}
variable "vm_sku" {
  description = "VM OS Sku."
default = "18_04-lts-gen2"
}
variable "vm_version" {
  description = "VM OS Version."
default = "18.04.202206150"
}
variable "vm_os_disk_sku" {
  description = "VM OS Disk Storage Type SKU."
default = "Standard_LRS"
}
variable "admin_username" {
  description = "VM Admin Username."
default = "superuser"
}
variable "admin_password" {
  description = "VM Admin Password."
default = "@Sup3rUs3r"
} 

resource "azurerm_network_interface" "vm_nic_morpheus" {
    location      = var.region_code

 resource_group_name  = var.rsg_name
 name         = local.nic_name
 ip_configuration {
  name              = "ipconfig1"
  subnet_id            = var.subnet_id
  private_ip_address_allocation  = "Dynamic"
 }
}
resource "azurerm_linux_virtual_machine" "vm_linux_morpheus" {
 location          = var.region_code
 resource_group_name     = var.rsg_name
 name            = var.instance_name
 network_interface_ids    = "${var.instance_name}-NIC001"
 size            = var.vm_size
 disable_password_authentication = false
 tags = {"systemType"="JoinedTrustedRedHat"}
 admin_username       = var.admin_username
 admin_password       = var.admin_password
 source_image_reference {
    publisher = var.vm_publisher
    offer   = var.vm_offer
    sku    = var.vm_sku
    version  = var.vm_version
  }
 os_disk {
   name          = "${var.instance_name}-MDK001"
   caching         = "ReadWrite"
   storage_account_type  = var.vm_os_disk_sku
  }
}

