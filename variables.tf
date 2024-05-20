# Environment Variables
# =====================

variable "environment" {
  description = "The Azure environment to use for the deployment."
  type        = string
  default     = "usgovernment"  // Default to Azure US Government Cloud
}

# Location Variable
# =====================

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default     = "usgovarizona"
}

# Resource Group Names
# =====================

variable "resource_group_name" {
  description = "Name of the resource group for the hub."
  default     = "hub-resources"
}

variable "mgmt_rg_name" {
  description = "Resource group name for the management VNet."
  default     = "mgmt-resources"
}

variable "prod_rg_name" {
  description = "The name of the Prod Resource Group"
  default     = "prod-rg"
}

variable "qa_rg_name" {
  description = "The name of the QA Resource Group"
  default     = "qa-rg"
}

variable "test_rg_name" {
  description = "The name of the Test Resource Group"
  default     = "test-rg"
}

# VNet Address Spaces
# =====================

variable "vnet_address_space" {
  description = "The address space for the Hub VNet."
  default     = ["10.0.0.0/16"]
}

variable "mgmt_vnet_address_space" {
  description = "Address space for the management VNet."
  default     = ["10.2.0.0/16"]
}

variable "prod_vnet_cidr" {
  description = "CIDR block for the Prod VNET"
  default     = "10.1.0.0/24"
}

variable "qa_vnet_cidr" {
  description = "CIDR block for the QA VNET"
  default     = "10.4.0.0/24"
}

variable "test_vnet_cidr" {
  description = "CIDR block for the Test VNET"
  default     = "10.3.0.0/24"
}

# Subnet Prefixes
# =====================

variable "appgw_subnet_prefix" {
  description = "Subnet prefix for the Application Gateway."
  default     = ["10.0.1.0/24"]
}

variable "fw_subnet_prefix" {
  description = "Subnet prefix for the Azure Firewall."
  default     = ["10.0.2.0/24"]
}

variable "mgmt_subnet_prefix" {
  description = "Subnet prefix for the management subnet."
  default     = ["10.2.1.0/24"]
}

variable "bastion_subnet_prefix" {
  description = "Subnet prefix for the Bastion host."
  default     = "10.0.3.0/27"
}

variable "entra_ds_subnet_prefix" {
  description = "Subnet prefix for Entra Domain Services."
  default     = "10.2.2.0/28"
}

# Firewall IP Address
# =====================

variable "fw_ip_address" {
  description = "IP address of the Azure Firewall used as next hop."
  default     = "10.0.2.4"
}

# Tenant ID (for Key Vault)
# =====================

variable "tenant_id" {
  description = "The Tenant ID for Azure AD."
  type        = string
}
