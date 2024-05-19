
variable "resource_prefix" {
  description = "Prefix for all resources"
  type        = string
  default     = "myapp"
}

variable "vnet_ip_ranges" {
  description = "IP ranges for the VNETs"
  type = map(string)
  default = {
    prod = "10.1.0.0/24"
    qa = "10.2.0.0/24"
    test = "10.3.0.0/24"
  }
}

variable "bastion_subnet_range" {
  description = "IP range for the Azure Bastion subnet"
  type = string
  default = "10.0.1.0/27"
}

variable "entra_domain_services_subnet_range" {
  description = "IP range for the Entra Domain Services subnet"
  type = string
  default = "10.0.2.0/28"
}
