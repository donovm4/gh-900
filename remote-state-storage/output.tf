output "resource_group_name" {
  value = module.avm-res-resources-resourcegroup.name
}

output "storage_account_name" {
  value = azurerm_storage_account.state.name
}

output "container_name" {
  value = azurerm_storage_container.state.name
}

output "github_secrets" {
  value = {
    AZURE_CLIENT_ID       = azurerm_user_assigned_identity.github.client_id
    AZURE_TENANT_ID       = data.azurerm_client_config.current.tenant_id
    AZURE_SUBSCRIPTION_ID = data.azurerm_client_config.current.subscription_id
  }
}

# output "client_id" {
#   value = azurerm_user_assigned_identity.github.client_id
# }

# output "tenant_id" {
#   value = data.azurerm_client_config.current.tenant_id
#   # sensitive = true
# }

# output "subscription_id" {
#   value = data.azurerm_client_config.current.subscription_id
#   # sensitive = true
# }
