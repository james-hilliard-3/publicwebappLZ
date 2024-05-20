# Outputs
# =====================

# Bastion Host Public IP
output "bastion_host_public_ip" {
  description = "The public IP address of the Bastion Host"
  value       = azurerm_public_ip.bastion_public_ip.ip_address
}

# Key Vault URI
output "key_vault_uri" {
  description = "The URI of the Azure Key Vault"
  value       = azurerm_key_vault.mgmt_kv.vault_uri
}

# Recovery Services Vault ID
output "recovery_services_vault_id" {
  description = "The ID of the Recovery Services Vault"
  value       = azurerm_recovery_services_vault.mgmt_rsv.id
}

# App Gateway Public IP
output "app_gateway_public_ip" {
  value = azurerm_public_ip.appgw_public_ip.ip_address
}

# Firewall Public IP
output "firewall_public_ip" {
  description = "The public IP address of the Azure Firewall"
  value       = azurerm_public_ip.firewall_public_ip.ip_address  # Corrected resource name
}
