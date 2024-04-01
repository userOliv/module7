



 

resource "azurerm_resource_group" "rgrup" {

  # count    = length(var.rgName)
  name     = var.rgName
  location = var.location
  # tags     = local.tags
  

}


resource "azurerm_storage_account" "sa1" {
  name                     = var.sa
  resource_group_name      =var.rgName # azurerm_resource_group.example.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  # tags = local.tags
}



/*resource "azurerm_storage_container" "storageContainer" {
  name                  = "ct1we1modweb71"
  storage_account_name  = azurerm_storage_account.sa1.name
  container_access_type = "private"
}*/



resource "azurerm_storage_blob" "blob1" {
  name                   =var.blobname
  storage_account_name   = azurerm_storage_account.sa1.name
  storage_container_name ="$web"# azurerm_storage_container.storageContainer.name
  type                   = "Block"
  content_type           ="txt/html"
  source_content         = var.source_content
}

output "primary_web_endpoint" {
    value = azurerm_storage_account.sa1.primary_web_endpoint
}


/*


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
 
 








 









