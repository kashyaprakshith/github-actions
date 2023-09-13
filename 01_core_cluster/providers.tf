terraform {
  backend "azurerm" {
    resource_group_name  = "cfx-devsecops-tfstates"
    storage_account_name = "cfxcoretfstates"
    container_name       = "core"
    key                  = "core.tfstate"
  }
}

provider "azurerm" {
  alias           = "default"
  client_id       = var.provider_service_principal_client_id
  client_certificate_path     = var.provider_service_principal_client_certificate_path
  client_certificate_password = var.provider_service_principal_client_certificate_password
  tenant_id       = var.provider_azure_tenant_id
  subscription_id = var.provider_azure_subscription_id
  features {}
}

provider "azurerm" {
  alias           = "speedboat"
  client_id       = var.provider_service_principal_client_id
  client_certificate_path     = var.provider_service_principal_client_certificate_path
  client_certificate_password = var.provider_service_principal_client_certificate_password
  tenant_id       = var.provider_azure_tenant_id
  subscription_id = var.provider_azure_dns_subscription_id
  features {}
}
