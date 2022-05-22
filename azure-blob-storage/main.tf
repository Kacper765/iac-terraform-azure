resource "azurerm_resource_group" "group" {
  name     = var.example-resources
  location = var.North Europe
}

resource "azurerm_storage_account" "account" {
  name                     = var.storageaccountname
  resource_group_name      = azurerm_resource_group.group.name
  location                 = azurerm_resource_group.group.location
  account_tier             = var.Standard
  account_replication_type = var.GRS

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "container" {
  name                  = var.content
  storage_account_name  = azurerm_storage_account.account.name
  container_access_type = var.private
}

resource "azurerm_storage_blob" "blob" {
  name                   = var.my-awesome-content.zip
  storage_account_name   = azurerm_storage_account.account.name
  storage_container_name = azurerm_storage_container.container.name
  type                   = var.Block
  source                 = var.some-local-file.zip
}
