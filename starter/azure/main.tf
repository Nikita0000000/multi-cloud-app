data "azurerm_resource_group" "udacity" {
  name     = "Regroup_0o0wQL"
}

resource "azurerm_container_group" "udacity" {
  name                = "udacity-continst"
  location            = data.azurerm_resource_group.udacity.location
  resource_group_name = data.azurerm_resource_group.udacity.name
  ip_address_type     = "Public"
  dns_name_label      = "hx-azure"
  os_type             = "Linux"

  container {
    name   = "azure-container-app"
    image  = "docker.io/nikita0598/azure_app:1.0"
    cpu    = "1"
    memory = "1.5"
    environment_variables = {
      "AWS_S3_BUCKET"       = "nikita-aws-s3-bucket",
      "AWS_DYNAMO_INSTANCE" = "nikita-aws-dynamodb"
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

resource "azurerm_sql_server" "udacity" {
  name                         = "nikita-azure-sql"
  resource_group_name          = data.azurerm_resource_group.udacity.name
  location                     = data.azurerm_resource_group.udacity.location
  version                      = "12.0"
  administrator_login          = "4dm1n157r470rhx"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd-hx"
  tags = {
    environment = "udacity"
  }
}

resource "azurerm_app_service_plan" "udacity" {
  name                = "nikita-azure-app-plan"
  location            = data.azurerm_resource_group.udacity.location
  resource_group_name = data.azurerm_resource_group.udacity.name
  kind                = "Windows"
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "udacity" {
  name                = "nikita-azure-dotnet-app"
  location            = data.azurerm_resource_group.udacity.location
  resource_group_name = data.azurerm_resource_group.udacity.name
  app_service_plan_id = azurerm_app_service_plan.udacity.id
  site_config {
    dotnet_framework_version = "v5.0"
  }
  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
  tags = {
    environment = "udacity"
  }
}
