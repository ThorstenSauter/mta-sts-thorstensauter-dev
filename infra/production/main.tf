data "cloudflare_zone" "this" {
  name = var.domain_name
}

resource "azurerm_resource_group" "main" {
  name     = local.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_static_web_app" "main" {
  name                = local.static_web_app_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku_tier            = var.sku
  sku_size            = var.sku
  tags                = var.tags
  lifecycle {
    ignore_changes = [
      repository_branch,
      repository_token,
      repository_url
    ]
  }
}

resource "azurerm_static_web_app_custom_domain" "primary" {
  static_web_app_id = azurerm_static_web_app.main.id
  domain_name       = time_sleep.record_creation.triggers["domain_name"]
  validation_type   = "cname-delegation"
}

resource "cloudflare_record" "mta_sts" {
  zone_id = data.cloudflare_zone.this.id
  name    = "mta-sts"
  type    = "CNAME"
  content = azurerm_static_web_app.main.default_host_name
  comment = "MTA-STS policy hosting site"
}

resource "time_sleep" "record_creation" {
  create_duration = "2m"
  triggers = {
    domain_name = cloudflare_record.mta_sts.hostname
  }
}

resource "cloudflare_record" "mta_sts_policy" {
  zone_id = data.cloudflare_zone.this.id
  name    = "_mta-sts"
  type    = "TXT"
  content = "v=STSv1; id=202407171852Z;"
  comment = "Indicates a MTA-STS policy being present for this domain"
}