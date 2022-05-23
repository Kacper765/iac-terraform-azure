# azurerm_app_service
# Manages an App Service (within an App Service Plan).
# This resource has been deprecated in version 3.0 of the AzureRM provider and will be removed in version 4.0. 
# Please use azurerm_linux_web_app and azurerm_windows_web_app resources instead.

resource "azurerm_resource_group" "group" {
  name     = "example-resources"
  location = "North Europe"
}

resource "azurerm_service_plan" "plan" {
  name                = "example"
  resource_group_name = azurerm_resource_group.group.name
  location            = azurerm_resource_group.group.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "app" {
  name                = "example"
  resource_group_name = azurerm_resource_group.group.name
  location            = azurerm_service_plan.app.location
  service_plan_id     = azurerm_service_plan.app.id

  site_config {}
}
