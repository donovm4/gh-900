variable "enable_telemetry" {
  type        = bool
  default     = true
  description = "Controls whether telemetry is collected by Azure Verified Modules. Set to false to opt out."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Azure resource group to create."
}

variable "location" {
  type        = string
  description = "The Azure region where the resource group will be deployed."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to apply to the resource group."
}
