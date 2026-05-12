variable "mandatory_tags" {
  description = "Mandatory tags"
  type        = map(any)
  default = {
    environment = "development" # Will be set to production in future
    status      = "active"
  }
}