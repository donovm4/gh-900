module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.3"

  unique-length = 8
}

module "avm-res-resources-resourcegroup" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "0.4.0"

  enable_telemetry = var.enable_telemetry
  name             = var.resource_group_name
  location         = var.location
  tags             = merge(var.tags, var.mandatory_tags)
}

resource "azurerm_user_assigned_identity" "github" {
  name                = "uami-github-terraform"
  resource_group_name = module.avm-res-resources-resourcegroup.name
  location            = module.avm-res-resources-resourcegroup.location
}

resource "azurerm_role_assignment" "contributor" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.github.principal_id
}

resource "azurerm_role_assignment" "storage_blob" {
  scope                = azurerm_storage_account.state.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_user_assigned_identity.github.principal_id
}

resource "azurerm_federated_identity_credential" "github-pr" {
  name                      = "github-oidc-pr"
  user_assigned_identity_id = azurerm_user_assigned_identity.github.id
  issuer                    = "https://token.actions.githubusercontent.com"
  subject                   = "repo:donovm4/gh-900:pull_request"
  audience                  = ["api://AzureADTokenExchange"]
}

resource "azurerm_federated_identity_credential" "github-develop" {
  name                      = "github-oidc-develop"
  user_assigned_identity_id = azurerm_user_assigned_identity.github.id
  issuer                    = "https://token.actions.githubusercontent.com"
  subject                   = "repo:donovm4/gh-900:ref:refs/heads/develop"
  audience                  = ["api://AzureADTokenExchange"]
}

resource "azurerm_federated_identity_credential" "github-main" {
  name                      = "github-oidc-main"
  user_assigned_identity_id = azurerm_user_assigned_identity.github.id
  issuer                    = "https://token.actions.githubusercontent.com"
  subject                   = "repo:donovm4/gh-900:ref:refs/heads/main"
  audience                  = ["api://AzureADTokenExchange"]
}

resource "azurerm_storage_account" "state" {
  name                     = module.naming.storage_account.name_unique
  resource_group_name      = module.avm-res-resources-resourcegroup.name
  location                 = module.avm-res-resources-resourcegroup.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = merge(var.tags, var.mandatory_tags)

  blob_properties {
    versioning_enabled = false
  }
}

resource "azurerm_storage_container" "state" {
  name                  = module.naming.storage_container.name_unique
  storage_account_id    = azurerm_storage_account.state.id
  container_access_type = "private"
}
