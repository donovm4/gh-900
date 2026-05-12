# Remote State Storage

## Overview

This directory contains the configuration that deploys the required infrastructure in which you can store the remote state, as well as some other resources for CI/CD.

### WHY would you use remote state storage

TBD

### Resources deployed (for remote states storage)

TBD

## How to deploy

### How to store remote state files

Use output and specify the following in the configurations for which you need to store state remotely:

```terraform
terraform {
  backend "azurerm" {
    resource_group_name  = "<from output>"
    storage_account_name = "<from output>"
    container_name       = "<from output>"
    key                  = "terraform.tfstate"
  }
}
```

## Additional resources for CI/CD

Regarding the IDs needed for the GitHub Actions, make note of the `github_secrets` output for the relevant values.
