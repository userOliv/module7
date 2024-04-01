

locals{ #dersom workspace sufiksen ikke er default gis det ut gjeldende workspace ellers default
workspace-sufiksen= terraform.workspace=="default"?"":"${terraform.workspace}"

rgName ="${var.rgName}-${local.workspace-sufiksen}"
source_content="${var.source_content}-${local.workspace-sufiksen}"

}

resource "random_string" "randomString" {
  length = 8
  upper  = false
  special = false
}

 

resource "azurerm_resource_group" "rgrup" {

  # count    = length(var.rgName)
  name     = local.rgName # Benytter ombygd rgname tillagt workspace-sufiksen
  location = var.location
  # tags     = local.tags
  

}


output "rgName" {
 value=azurerm_resource_group.rgrup.name 
}


resource "azurerm_storage_account" "sa1" {
  name                     ="${var.sa}${random_string.randomString.result}"
  resource_group_name      =local.rgName # azurerm_resource_group.example.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  # tags = local.tags

  static_website {
    index_document = var.index_document
  }
}



/*resource "azurerm_storage_container" "storageContainer" {
  name                  = "ct1we1modweb71"
  storage_account_name  = azurerm_storage_account.sa1.name
  container_access_type = "private"
}*/



resource "azurerm_storage_blob" "blob1" {
  name                   =var.index_document
  storage_account_name   = azurerm_storage_account.sa1.name
  storage_container_name ="$web"# azurerm_storage_container.storageContainer.name
  type                   = "Block"
  content_type           ="html"   #"text/html" dersom man vil ha nedlastbare dokument isted for kun web tekst
  source_content         = local.source_content
}

output "primary_web_endpoint" {
    value = azurerm_storage_account.sa1.primary_web_endpoint
}


/*

terraform workspace list      -lister ut tilgjengelig workspaces
terraform workspace new dev    -Lager en ny workspace med navnet dev
terraform workspace select dev   - Endrer gjeldende workspace til å stå i dev
terraform workspace dele dev      -sleter angitt dev workspace
terraform workspace show          -viser gjeldende workspace

data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "kv" {
  name                        = "kv1we1mod61"
  location                    = var.location
  resource_group_name         = var.rgName
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get","List","Create",
    ]

    secret_permissions = [
      "Get","Set","List",
    ]

     storage_permissions = [
      "Get","Set","List",
    ]

  }
}

resource "azurerm_key_vault_secret" keyvsec{
name="ba1accessKey"
value=azurerm_storage_account.sa1.primary_access_key
key_vault_id= azurerm_key_vault.kv.id
}


*/
 
 








 









