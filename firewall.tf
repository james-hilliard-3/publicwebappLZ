# Public IP for Azure Firewall
resource "azurerm_public_ip" "firewall_public_ip" {
  name                = "firewall-public-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.hub_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Azure Firewall Premium
resource "azurerm_firewall" "firewall" {
  name                = "my-azure-firewall"
  location            = var.location
  resource_group_name = azurerm_resource_group.hub_rg.name

  sku_name = "AZFW_VNet"
  sku_tier = "Premium"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.fw_subnet.id
    public_ip_address_id = azurerm_public_ip.firewall_public_ip.id
  }
}