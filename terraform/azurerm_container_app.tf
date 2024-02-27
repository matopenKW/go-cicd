/**
 * Container Registry
*/
resource "azurerm_container_registry" "go_cicd_cr" {
  name                          = "gocicdcr"
  resource_group_name           = azurerm_resource_group.go_cicd_rg.name
  location                      = azurerm_resource_group.go_cicd_rg.location
  sku                           = "Standard"
  public_network_access_enabled = true
  admin_enabled                 = true
  anonymous_pull_enabled        = false
  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.go_cicd_uai.id
    ]
  }
}

resource "azurerm_role_assignment" "go_cicd_ca_rbac" {
  scope                = azurerm_container_registry.go_cicd_cr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.go_cicd_uai.principal_id
}

resource "azurerm_user_assigned_identity" "go_cicd_uai" {
  name                = "go_cicd_uai"
  location            = azurerm_resource_group.go_cicd_rg.location
  resource_group_name = azurerm_resource_group.go_cicd_rg.name
}

/**
 * Container App
*/
resource "azurerm_container_app_environment" "go_cicd_app_environment" {
  location            = "australiaeast"
  name                = "go-cicd-2"
  resource_group_name = azurerm_resource_group.go_cicd_rg.name
}

resource "azurerm_container_app" "go_cicd_app" {
  container_app_environment_id = azurerm_container_app_environment.go_cicd_app_environment.id
  name                         = "test2"
  resource_group_name          = azurerm_resource_group.go_cicd_rg.name
  revision_mode                = "Single"

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.go_cicd_uai.id]
  }

  registry {
    server   = azurerm_container_registry.go_cicd_cr.login_server
    identity = azurerm_user_assigned_identity.go_cicd_uai.id
  }

  template {
    max_replicas = 1
    container {
      command = ["/bin/http"]
      cpu     = 0.5
      image = "${azurerm_container_registry.go_cicd_cr.login_server}/develop:latest"
      memory  = "1Gi"
      name    = "test"
    }
  }
}
