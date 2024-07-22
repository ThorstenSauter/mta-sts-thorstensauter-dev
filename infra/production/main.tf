resource "azurerm_resource_group" "main" {
  name     = local.resource_group_name
  location = var.location
  tags     = var.tags
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_static_web_app" "main" {
  name                = local.static_web_app_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku_tier            = var.sku
  sku_size            = var.sku
  tags                = var.tags
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_static_web_app_custom_domain" "primary" {
  static_web_app_id = azurerm_static_web_app.main.id
  domain_name       = var.custom_domain_name
  validation_type   = "cname-delegation"
  lifecycle {
    prevent_destroy = true
  }
}
