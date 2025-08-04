variable "resource_group_name" {
  default = "rg-testenv"
}
variable "location" {
  default = "East US"
}
variable "vm_name" {
  default = "ansibletest"
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

