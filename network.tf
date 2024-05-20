# Resource Groups
# =====================

# Resource Group for Hub
resource "azurerm_resource_group" "hub_rg" {
  name     = var.resource_group_name
  location = var.location
}

# Resource Group for Prod
resource "azurerm_resource_group" "prod" {
  name     = var.prod_rg_name
  location = var.location
}

# Resource Group for QA
resource "azurerm_resource_group" "qa" {
  name     = var.qa_rg_name
  location = var.location
}

# Resource Group for Test
resource "azurerm_resource_group" "test" {
  name     = var.test_rg_name
  location = var.location
}

# Resource Group for Management
resource "azurerm_resource_group" "mgmt_rg" {
  name     = var.mgmt_rg_name
  location = var.location
}

# Virtual Networks
# =====================

# Hub VNet
resource "azurerm_virtual_network" "hub_vnet" {
  name                = "hub-vnet"
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.hub_rg.location
  resource_group_name = azurerm_resource_group.hub_rg.name
}

# Virtual Network for Prod
resource "azurerm_virtual_network" "prod" {
  name                = "prod-vnet"
  address_space       = [var.prod_vnet_cidr]
  location            = var.location
  resource_group_name = azurerm_resource_group.prod.name
}

# Virtual Network for QA
resource "azurerm_virtual_network" "qa" {
  name                = "qa-vnet"
  address_space       = [var.qa_vnet_cidr]
  location            = var.location
  resource_group_name = azurerm_resource_group.qa.name
}

# Virtual Network for Test
resource "azurerm_virtual_network" "test" {
  name                = "test-vnet"
  address_space       = [var.test_vnet_cidr]
  location            = var.location
  resource_group_name = azurerm_resource_group.test.name
}

# Virtual Network for Management
resource "azurerm_virtual_network" "mgmt_vnet" {
  name                = "mgmt-vnet"
  address_space       = var.mgmt_vnet_address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.mgmt_rg.name
}

# Subnets
# =====================

# Subnet for Application Gateway in the Hub VNet
resource "azurerm_subnet" "appgw_subnet" {
  name                 = "appgw-subnet"
  resource_group_name  = azurerm_resource_group.hub_rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = var.appgw_subnet_prefix
}

# Subnet for Azure Firewall in the Hub VNet
resource "azurerm_subnet" "fw_subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.hub_rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = var.fw_subnet_prefix
}

# Management Subnet in Management VNet
resource "azurerm_subnet" "mgmt_subnet" {
  name                 = "mgmt-subnet"
  resource_group_name  = azurerm_resource_group.mgmt_rg.name
  virtual_network_name = azurerm_virtual_network.mgmt_vnet.name
  address_prefixes     = var.mgmt_subnet_prefix
}

# Subnet for Bastion Host in the Hub VNet
resource "azurerm_subnet" "bastion_subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.hub_rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = [var.bastion_subnet_prefix]
}

# Subnet for Entra Domain Services in the Management VNET
resource "azurerm_subnet" "entra_ds_subnet" {
  name                 = "entra-ds-subnet"
  resource_group_name  = azurerm_resource_group.mgmt_rg.name
  virtual_network_name = azurerm_virtual_network.mgmt_vnet.name
  address_prefixes     = [var.entra_ds_subnet_prefix]
}

# Network Security Groups (NSGs)
# =====================

# Network Security Group for Prod
resource "azurerm_network_security_group" "prod" {
  name                = "prod-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.prod.name
}

# Network Security Group for QA
resource "azurerm_network_security_group" "qa" {
  name                = "qa-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.qa.name
}

# Network Security Group for Test
resource "azurerm_network_security_group" "test" {
  name                = "test-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.test.name
}

# Route Tables and Routes
# =====================

# Route Table for Prod with route to Azure Firewall
resource "azurerm_route_table" "prod" {
  name                = "prod-rt"
  location            = var.location
  resource_group_name = azurerm_resource_group.prod.name
}

resource "azurerm_route" "prod_to_firewall" {
  name                   = "prod-to-firewall"
  resource_group_name    = azurerm_resource_group.prod.name
  route_table_name       = azurerm_route_table.prod.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = var.fw_ip_address
}

# Route Table for QA with route to Azure Firewall
resource "azurerm_route_table" "qa" {
  name                = "qa-rt"
  location            = var.location
  resource_group_name = azurerm_resource_group.qa.name
}

resource "azurerm_route" "qa_to_firewall" {
  name                   = "qa-to-firewall"
  resource_group_name    = azurerm_resource_group.qa.name
  route_table_name       = azurerm_route_table.qa.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = var.fw_ip_address
}

# Route Table for Test with route to Azure Firewall
resource "azurerm_route_table" "test" {
  name                = "test-rt"
  location            = var.location
  resource_group_name = azurerm_resource_group.test.name
}

resource "azurerm_route" "test_to_firewall" {
  name                   = "test-to-firewall"
  resource_group_name    = azurerm_resource_group.test.name
  route_table_name       = azurerm_route_table.test.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = var.fw_ip_address
}

# Route Table for Management with route to Azure Firewall
resource "azurerm_route_table" "mgmt_route_table" {
  name                = "mgmt-rt"
  location            = var.location
  resource_group_name = azurerm_resource_group.mgmt_rg.name
}

resource "azurerm_route" "mgmt_to_firewall" {
  name                   = "mgmt-to-firewall"
  resource_group_name    = azurerm_resource_group.mgmt_rg.name
  route_table_name       = azurerm_route_table.mgmt_route_table.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = var.fw_ip_address
}

# Route Table Associations
# =====================

# Associate Route Table to Prod VNet
resource "azurerm_subnet_route_table_association" "prod_route_table_association" {
  subnet_id      = azurerm_subnet.prod_subnet.id
  route_table_id = azurerm_route_table.prod.id
}

# Associate Route Table to QA VNet
resource "azurerm_subnet_route_table_association" "qa_route_table_association" {
  subnet_id      = azurerm_subnet.qa_subnet.id
  route_table_id = azurerm_route_table.qa.id
}

# Associate Route Table to Test VNet
resource "azurerm_subnet_route_table_association" "test_route_table_association" {
  subnet_id      = azurerm_subnet.test_subnet.id
  route_table_id = azurerm_route_table.test.id
}

# Associate Route Table to Management VNet
resource "azurerm_subnet_route_table_association" "mgmt_route_table_association" {
  subnet_id      = azurerm_subnet.mgmt_subnet.id
  route_table_id = azurerm_route_table.mgmt_route_table.id
}

# Virtual Network Peering
# =====================

# Peering between Hub VNet and Management VNet
resource "azurerm_virtual_network_peering" "hub_to_mgmt_peering" {
  name                      = "hub-to-mgmt-peering"
  resource_group_name       = azurerm_resource_group.hub_rg.name
  virtual_network_name      = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.mgmt_vnet.id
}

resource "azurerm_virtual_network_peering" "mgmt_to_hub_peering" {
  name                      = "mgmt-to-hub-peering"
  resource_group_name       = azurerm_resource_group.mgmt_rg.name
  virtual_network_name      = azurerm_virtual_network.mgmt_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id
}

# Peering between Hub VNet and Prod VNet
resource "azurerm_virtual_network_peering" "hub_to_prod_peering" {
  name                      = "hub-to-prod-peering"
  resource_group_name       = azurerm_resource_group.hub_rg.name
  virtual_network_name      = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.prod.id
}

resource "azurerm_virtual_network_peering" "prod_to_hub_peering" {
  name                      = "prod-to-hub-peering"
  resource_group_name       = azurerm_resource_group.prod.name
  virtual_network_name      = azurerm_virtual_network.prod.name
  remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id
}

# Peering between Hub VNet and QA VNet
resource "azurerm_virtual_network_peering" "hub_to_qa_peering" {
  name                      = "hub-to-qa-peering"
  resource_group_name       = azurerm_resource_group.hub_rg.name
  virtual_network_name      = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.qa.id
}

resource "azurerm_virtual_network_peering" "qa_to_hub_peering" {
  name                      = "qa-to-hub-peering"
  resource_group_name       = azurerm_resource_group.qa.name
  virtual_network_name      = azurerm_virtual_network.qa.name
  remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id
}

# Peering between Hub VNet and Test VNet
resource "azurerm_virtual_network_peering" "hub_to_test_peering" {
  name                      = "hub-to-test-peering"
  resource_group_name       = azurerm_resource_group.hub_rg.name
  virtual_network_name      = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.test.id
}

resource "azurerm_virtual_network_peering" "test_to_hub_peering" {
  name                      = "test-to-hub-peering"
  resource_group_name       = azurerm_resource_group.test.name
  virtual_network_name      = azurerm_virtual_network.test.name
  remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id
}

# Key Vault and Recovery Services Vault
# =====================

# Azure Key Vault in Management RG
resource "azurerm_key_vault" "mgmt_kv" {
  name                = "mgmt-kv"
  location            = azurerm_resource_group.mgmt_rg.location
  resource_group_name = azurerm_resource_group.mgmt_rg.name
  tenant_id           = var.tenant_id
  sku_name            = "standard"

  soft_delete_enabled = true
}

# Recovery Services Vault in Management RG with GRS redundancy
resource "azurerm_recovery_services_vault" "mgmt_rsv" {
  name                = "mgmt-rsv"
  location            = azurerm_resource_group.mgmt_rg.location
  resource_group_name = azurerm_resource_group.mgmt_rg.name
  sku                 = "Standard"
  redundancy          = "GRS"
}

# Bastion Host
# =====================

resource "azurerm_bastion_host" "bastion" {
  name                = "bastion-host"
  location            = azurerm_resource_group.hub_rg.location
  resource_group_name = azurerm_resource_group.hub_rg.name
  dns_name            = "bastion${random_string.prefix.result}.eastus.azure.bastion"

  sku {
    name = "Basic"
  }

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion_subnet.id
    public_ip_address_id = azurerm_public_ip.bastion_public_ip.id
  }
}

# Public IP for Bastion Host
resource "azurerm_public_ip" "bastion_public_ip" {
  name                = "bastion-public-ip"
  location            = azurerm_resource_group.hub_rg.location
  resource_group_name = azurerm_resource_group.hub_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Random string for DNS name
resource "random_string" "prefix" {
  length  = 8
  special = false
}
