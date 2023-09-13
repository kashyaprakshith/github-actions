variable "provider_service_principal_client_id" {
  description = "The service principal client id to authenticate to Azure"
  type        = string
}

# variable "provider_service_principal_client_secret" {
#   description = "The service principal client secret to authenticate to Azure"
#   type        = string
# }

variable "provider_azure_tenant_id" {
  description = "The Azure tenant ID use"
  type = string
}

variable "provider_azure_subscription_id" {
  description = "The Azure subscription ID"
}

variable "provider_azure_dns_subscription_id" {
  description = "The Azure subscription ID for the DNS entries. Only used, because DNS zone and AKS resources are in different subscriptions"
  type = string
}

variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
  default     = "core"
}

variable "provider_service_principal_client_certificate_path" {
  description = "The service principal client certficate path (.pfx file)"
  type        = string
}

variable "provider_service_principal_client_certificate_password" {
  description = "The service principal client certificate password"
  type        = string
}

variable "resource_group_location" {
  description = "The Azure region location for the resource group. Should also be used to set the location of all other resources"
  type        = string
  default     = "westeurope"
}

variable "zone_name" {
  description = "The name of the DNS zone, where the A record belongs to. I.e. interim.cofinity-x.com"
  type        = string
  default     = "cofinity-x.com"
}

variable "vault_aks_resource_group" {
  description = "AKS managed resource group of the Vault cluster" # Value of this variable may change in case of cluster re-creation
  type = string
  default = "mc_cfx-vault-rg_cfx-vault-aks_westeurope"
}

variable "hashicorp_vault_disks" {
  description = "List of persistent disks of hashi corp vault cluster"
  type = set(string)
  default = [ "pvc-09604c48-ffc3-49fc-a9ad-4b7bb6a3dc72", "pvc-881249cc-9c75-40bc-86b6-6288e8221e13", "pvc-bd798eeb-331d-415b-83b7-c21b5e5fe6e4" ]
}
