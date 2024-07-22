locals {
  resource_group_name = "rg-${var.app_name}-${var.env}-${var.resource_id}"
  static_web_app_name = "stapp-${var.app_name}-${var.env}-${substr(var.resource_id, length(var.resource_id) - 2, 2)}"
}