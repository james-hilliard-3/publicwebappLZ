
variable "resource_prefix" {
  description = "Prefix for all resources"
  type        = string
  default     = "myapp"
}

variable "location" {
  description = "The Azure region to deploy resources."
  type        = string
  default     = "East US"
}

# Assuming no other variables are duplicated, the rest are maintained as unique definitions
