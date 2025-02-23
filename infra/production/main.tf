module "mta_sts" {
  source                    = "github.com/ThorstenSauter/mta-sts-cloudflare-azure-static-web-app?ref=1.0.3"
  domain                    = "thorstensauter.dev"
  azure_location            = var.location
  azure_resource_group_name = "rg-mta-sts-thorstensauter-dev-prod-001"
  azure_static_web_app_name = "stapp-mta-sts-thorstensauter-dev-prod-01"
  azure_tags                = var.tags
  mta_sts_mode              = "enforce"
  mx_hosts = [
    "thorstensauter-dev.a-v1.mx.microsoft"
  ]
  rua = [
    "mailto:tls-report@thorstensauter.dev"
  ]
}
