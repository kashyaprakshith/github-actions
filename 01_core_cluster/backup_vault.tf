# Create backup vault
resource "azurerm_data_protection_backup_vault" "backup_vault" {
  provider            = azurerm.default
  name                = "cfx-backup-vault"
  resource_group_name = "cfx-${var.cluster_name}-rg"
  location            = var.resource_group_location
  datastore_type      = "VaultStore"
  redundancy          = "LocallyRedundant"
  identity {
    type = "SystemAssigned"
  }
}

# Create a backup policy for Hashicorp vault disks
resource "azurerm_data_protection_backup_policy_disk" "hashicorp_vault_disks_backup_policy" {
  provider = azurerm.default
  name     = "hashicorp-vault-disks-backup-policy"
  vault_id = azurerm_data_protection_backup_vault.backup_vault.id

  backup_repeating_time_intervals = ["R/2023-07-26T00:00:00+00:00/P1D"] # P1D -> Backup every day
  default_retention_duration      = "P7D"
}

# Assign disk contributor role to the backup vault
resource "azurerm_role_assignment" "disk_snapshot_contributor" {
  provider             = azurerm.default
  scope                = module.core_cluster.aks_resource_group_id
  role_definition_name = "Disk Snapshot Contributor"
  principal_id         = azurerm_data_protection_backup_vault.backup_vault.identity[0].principal_id
}

# Get data of existing disks
data "azurerm_managed_disk" "disk_hashicorp_vault" {
  for_each            = var.hashicorp_vault_disks
  provider            = azurerm.default
  name                = "${each.key}"
  resource_group_name = var.vault_aks_resource_group
}

# Assign disk backup reader role to the backup vault
resource "azurerm_role_assignment" "disk_backup_contributor" {
  for_each             = data.azurerm_managed_disk.disk_hashicorp_vault
  provider             = azurerm.default
  scope                = each.value.id
  role_definition_name = "Disk Backup Reader"
  principal_id         = azurerm_data_protection_backup_vault.backup_vault.identity[0].principal_id
}

# Create backup instance for disk 1
resource "azurerm_data_protection_backup_instance_disk" "backup_disk_hashicorp_vault" {
  for_each                     = data.azurerm_managed_disk.disk_hashicorp_vault
  provider                     = azurerm.default
  name                         = "backup-disk-hashicorp-vault-${each.value.name}"
  location                     = var.resource_group_location
  vault_id                     = azurerm_data_protection_backup_vault.backup_vault.id
  disk_id                      = each.value.id
  snapshot_resource_group_name = azurerm_data_protection_backup_vault.backup_vault.resource_group_name
  backup_policy_id             = azurerm_data_protection_backup_policy_disk.hashicorp_vault_disks_backup_policy.id
}
