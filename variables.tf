variable "resource_group_name" {
  default = "rg-auto-vm"
}
variable "location" {
  default = "East US"
}
variable "vm_name" {
  default = "auto-vm"
}
variable "vm_size" {
  default = "Standard_B2s"
}
variable "admin_username" {
  default = "azureuser"
}
variable "disk_size_gb" {
  default = 10
}

