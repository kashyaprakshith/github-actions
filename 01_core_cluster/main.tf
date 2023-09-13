module "core_cluster" {
  source = "../modules/consortium_cluster"

  providers = {
    azurerm.default   = azurerm.default
    azurerm.speedboat = azurerm.speedboat
  }

  cluster_name            = var.cluster_name


  provider_azure_dns_subscription_id       = var.provider_azure_dns_subscription_id
  provider_azure_subscription_id           = var.provider_azure_subscription_id
  provider_azure_tenant_id                 = var.provider_azure_tenant_id
  provider_service_principal_client_id     = var.provider_service_principal_client_id
  provider_service_principal_client_certificate_path      = var.provider_service_principal_client_certificate_path
  provider_service_principal_client_certificate_password  = var.provider_service_principal_client_certificate_password
  
}

resource "azurerm_storage_account" "cofinity-x_public_assets" {
  provider = azurerm.default
  name                          = "cfxpublicassets"
  resource_group_name           = "cfx-${var.cluster_name}-rg"
  location                      = var.resource_group_location
  account_tier                  = "Standard"
  account_replication_type      = "GRS"
  public_network_access_enabled = true
  enable_https_traffic_only     = true

  blob_properties {
    versioning_enabled  = true
    change_feed_enabled = true
    delete_retention_policy {
      days = 31
    }
    restore_policy {
      days = 30
    }
    container_delete_retention_policy {
      days = 30
    }
  }
}

resource "azurerm_storage_container" "cofinity-x_public_assets_miw" {
  provider              = azurerm.default
  name                  = "miw"
  storage_account_name  = azurerm_storage_account.cofinity-x_public_assets.name
  container_access_type = "blob"
}

resource "azurerm_storage_container" "cofinity-x_public_assets_sd_factory" {
  provider              = azurerm.default
  name                  = "sd-factory"
  storage_account_name  = azurerm_storage_account.cofinity-x_public_assets.name
  container_access_type = "blob"
}
