module "avm-res-resources-resourcegroup" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "0.4.0"

  enable_telemetry = var.enable_telemetry
  name = var.resource_group_name
  location = var.location
  tags = var.tags
}
