variable "enable_telemetry" {
  type        = bool
  default     = true
  description = "Controls whether telemetry is collected by Azure Verified Modules. Set to false to opt out."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group for the Terraform state storage."
}

variable "location" {
  type        = string
  description = "The Azure region for the state storage resources."
}

# variable "storage_account_name" {
#   type        = string
#   description = "The name of the storage account for Terraform remote state. Must be globally unique."
# }

# variable "container_name" {
#   type        = string
#   default     = "tfstate"
#   description = "The name of the blob container that holds the Terraform state files."
# }

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to apply to the state storage resources."
}