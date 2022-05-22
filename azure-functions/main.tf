resource "azurerm_resource_group" "group" {
  name     = var."example-resources"
  location = var."North Europe"
}

resource "azurerm_storage_account" "account" {
  name                     = var."storageaccountname"
  resource_group_name      = azurerm_resource_group.group.name
  location                 = azurerm_resource_group.group.location
  account_tier             = var."Standard"
  account_replication_type = var."GRS"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_service_plan" "plan" {
  name                = var."example"
  resource_group_name = azurerm_resource_group.group.name
  location            = azurerm_resource_group.group.location
  os_type             = var."Linux"
  sku_name            = var."FREE"
}

resource "azurerm_linux_function_app" "app" {
  name                = var."example-linux-function-app"
  resource_group_name = azurerm_resource_group.group.name
  location            = azurerm_resource_group.group.location

  storage_account_name = azurerm_storage_account.account.name
  service_plan_id      = azurerm_service_plan.plan.id

  site_config {}
}

resource "azurerm_function_app_function" "function" {
  name            = var."example-function-app-function"
  function_app_id = azurerm_linux_function_app.app.id
  language        = var."Python"
  test_data = jsonencode({
    "name" = "Azure"
  })
  config_json = jsonencode({
    "bindings" = [
      {
        "authLevel" = "function"
        "direction" = "in"
        "methods" = [
          "get",
          "post",
        ]
        "name" = "req"
        "type" = "httpTrigger"
      },
      {
        "direction" = "out"
        "name"      = "$return"
        "type"      = "http"
      },
    ]
  })
}
