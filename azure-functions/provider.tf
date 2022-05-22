terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.7.0"
    }
  }
}

provider "azurerm" {
  features {}
}

#verion 3.7.0 - najnowsza wersja azurerm na 22.05.2022
