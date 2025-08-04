variable "resource_group_name" {
  default = "rg-testenv"
}
variable "location" {
  default = "East US"
}
variable "ansiblevm" {
  default = "auto-vm"
}
variable "vm_size" {
  default = "Standard_B2s"
}
variable "testadmin" {
  default = "azureuser"
}
variable "disk_size_gb" {
  default = 10
}

