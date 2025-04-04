terraform {
  backend "azurerm" {
    resource_group_name  = "TFDeploy-rg"
    storage_account_name = "marktfstorage"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "bf0ff2fe-5503-48b0-8b52-cd0e67aa8fd8"
}

variable "sites_markharrisonTF_name" {
  description = "The name of the App Service"
}

variable "serverFarms_TFDeployAppPlan_externalid" {
  default = "/subscriptions/bf0ff2fe-5503-48b0-8b52-cd0e67aa8fd8/resourceGroups/TFDeploy-rg/providers/Microsoft.Web/serverFarms/TFDeployAppPlan"
}

resource "azurerm_windows_web_app" "example" {
  name                = var.sites_markharrisonTF_name
  location            = "UK South"
  resource_group_name = "TFDeploy-rg"
  service_plan_id     = var.serverFarms_TFDeployAppPlan_externalid

  site_config {
    always_on     = false
    http2_enabled = false
  }

  tags = {
    "hidden-link: /app-insights-resource-id"         = "/subscriptions/bf0ff2fe-5503-48b0-8b52-cd0e67aa8fd8/resourceGroups/TFDeploy-rg/providers/microsoft.insights/components/markharrisonTF"
    "hidden-link: /app-insights-instrumentation-key" = "4e80f63d-cd54-4e3a-8047-2f70716df488"
    "hidden-link: /app-insights-conn-string"         = "InstrumentationKey=4e80f63d-cd54-4e3a-8047-2f70716df488;IngestionEndpoint=https://uksouth-1.in.applicationinsights.azure.com/;LiveEndpoint=https://uksouth.livediagnostics.monitor.azure.com/;ApplicationId=1b24cca6-36e8-4dbb-a26e-7f4e14e5bcf6"
  }
}
