terraform {
  required_version = ">= 1.9"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "state" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_storage_account" "state" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.state.name
  location                 = azurerm_resource_group.state.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  tags                     = var.tags

  blob_properties {
    versioning_enabled = true
  }
}

resource "azurerm_storage_container" "state" {
  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.state.id
  container_access_type = "private"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group for the Terraform state storage."
}

variable "location" {
  type        = string
  description = "The Azure region for the state storage resources."
}

variable "storage_account_name" {
  type        = string
  description = "The name of the storage account for Terraform remote state. Must be globally unique."
}

variable "container_name" {
  type        = string
  default     = "tfstate"
  description = "The name of the blob container that holds the Terraform state files."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to apply to the state storage resources."
}

output "resource_group_name" {
  value = azurerm_resource_group.state.name
}

output "storage_account_name" {
  value = azurerm_storage_account.state.name
}

output "container_name" {
  value = azurerm_storage_container.state.name
}
