
variable "resource_prefix" {
  description = "Prefix for all resources"
  type        = string
  default     = "jhapp"
}

variable "prod_rg_name" {
  description = "Resource group name for production"
  type        = string
  default     = "${var.resource_prefix}-prod-rg"
}

variable "qa_rg_name" {
  description = "Resource group name for QA"
  type        = string
  default     = "${var.resource_prefix}-qa-rg"
}

variable "test_rg_name" {
  description = "Resource group name for Test"
  type        = string
  default     = "${var.resource_prefix}-test-rg"
}

variable "prod_vnet_name" {
  description = "Virtual network name for production"
  type        = string
  default     = "${var.resource_prefix}-prod-vnet"
}

variable "qa_vnet_name" {
  description = "Virtual network name for QA"
  type        = string
  default     = "${var.resource_prefix}-qa-vnet"
}

variable "test_vnet_name" {
  description = "Virtual network name for Test"
  type        = string
  default     = "${var.resource_prefix}-test-vnet"
}

variable "nsg_suffix" {
  description = "Suffix for NSGs"
  type        = string
  default     = "-nsg"
}

variable "route_table_suffix" {
  description = "Suffix for route tables"
  type        = string
  default     = "-rt"
}

variable "prod_vnet_ip_range" {
  description = "IP range for the production VNET"
  type        = string
  default     = "10.1.0.0/24"
}

variable "qa_vnet_ip_range" {
  description = "IP range for the QA VNET"
  type        = string
  default     = "10.2.0.0/24"
}

variable "test_vnet_ip_range" {
  description = "IP range for the Test VNET"
  type        = string
  default     = "10.3.0.0/24"
}

variable "azure_bastion_subnet_range" {
  description = "IP range for the Azure Bastion subnet"
  type        = string
  default     = "10.0.1.0/27"
}

variable "entra_domain_services_subnet_range" {
  description = "IP range for the Entra Domain Services subnet"
  type        = string
  default     = "10.0.2.0/28"
}
