
variable "location" {
  description = "The Azure region to deploy resources."
  type        = string
  default     = "East US"
}

variable "resource_prefix" {
  description = "Prefix for all resources"
  type        = string
  default     = "myapp"
}

variable "hub_rg" {
  description = "The name of the resource group for the hub network."
  type        = string
}

variable "management_rg" {
  description = "The name of the resource group for management resources."
  type        = string
}

variable "management_vnet" {
  description = "The name of the virtual network for management resources."
  type        = string
}

variable "firewall_private_ip" {
  description = "The private IP address of the Azure Firewall."
  type        = string
}

variable "bastion_public_ip" {
  description = "The public IP address for the Bastion Host."
  type        = string
}
variable "environment" {
  description = "The Azure environment to use for the deployment."
  type        = string
  default     = "usgovernment"  // Default to Azure US Government Cloud
}

variable "location" {
    description = "The Azure Region in which all resources in this example should be created."
    default     = "usgovarizona"
  }
  
  variable "resource_group_name" {
    description = "Name of the resource group for the hub."
    default     = "hub-resources"
  }
  
  variable "mgmt_rg_name" {
    description = "Resource group name for the management VNet."
    default     = "mgmt-resources"
  }
  
  variable "vnet_address_space" {
    description = "The address space for the Hub VNet."
    default     = ["10.0.0.0/16"]
  }
  
  variable "mgmt_vnet_address_space" {
    description = "Address space for the management VNet."
    default     = ["10.2.0.0/16"]
  }
  
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
  
  variable "fw_ip_address" {
    description = "IP address of the Azure Firewall used as next hop."
    default     = "10.0.2.4"
  }
  
