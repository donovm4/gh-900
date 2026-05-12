output "resource_group" {
  value = {
    name     = module.avm-res-resources-resourcegroup.name
    location = module.avm-res-resources-resourcegroup.location
  }
}