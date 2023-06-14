data "azurerm_resource_group" "udacity" {
  name     = "Regroup_7giQVMt6iq7MrN8WJIWd"
}

resource "azurerm_container_group" "udacity" {
  name                = "udacity-continst"
  location            = data.azurerm_resource_group.udacity.location
  resource_group_name = data.azurerm_resource_group.udacity.name
  ip_address_type     = "Public"
  dns_name_label      = "udacity-nikitaazure"
  os_type             = "Linux"

  container {
    name   = "azure-container-app"
    image  = "docker.io/nikita0598/azure_app:1.0"
    cpu    = "1"
    memory = "1.5"
    environment_variables = {
      "AWS_S3_BUCKET"       = "udacity-nikita-aws-s3-bucket",
      "AWS_DYNAMO_INSTANCE" = "udacity-nikita-aws-dynamodb"
    }

    ports {
      port     = 3000
      protocol = "TCP"
    }
  }
  tags = {
    environment = "udacity"
  }
}

####### Your Additions Will Start Here ######

resource "azurerm_mssql_server" "udacity" {
  name                         = "udacity-nikita-azure-sql"
  resource_group_name          = data.azurerm_resource_group.udacity.name
  location                     = data.azurerm_resource_group.udacity.location
  version                      = "12.0"
  administrator_login          = "4dm1n157r470rhx"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd-hx"
  tags = {
    environment = "udacity"
  }

}

resource "azurerm_service_plan" "udacity" {
  name                = "udacity-nikita-app-service-plan"
  location            = data.azurerm_resource_group.udacity.location
  resource_group_name = data.azurerm_resource_group.udacity.name
  kind                = "Windows"
  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_windows_web_app" "udacity" {
  name                = "udacity-nikita-azure-dotnet-app"
  location            = data.azurerm_resource_group.udacity.location
  resource_group_name = data.azurerm_resource_group.udacity.name
  service_plan_id     = azurerm_service_plan.udacity.id
  
  site_config {
    always_on = true
  }
  
  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
    "net_framework_version" = "v5.0"
  }
}
