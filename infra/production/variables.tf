variable "app_name" {
  type        = string
  description = "The application name used in created resource names."
}

variable "domain_name" {
  type        = string
  description = "The name of the domain for which to provision the MTA-STS website for."
}

variable "env" {
  type        = string
  description = "The shorthand name of the environment the infrastructure is deployed to."
}

variable "location" {
  type        = string
  description = "The Azure region where the resources will be deployed."
}

variable "resource_id" {
  type        = string
  description = "The id appended to resource names in order to make them unique."
}

variable "sku" {
  type        = string
  description = "The SKU Name for the static web app."
  default     = "Free"
  validation {
    condition     = contains(["Free", "Standard"], var.sku)
    error_message = "The SKU has to be one of 'Free' or 'Standard'."
  }
}

variable "tags" {
  type        = map(string)
  description = "The default tags for Azure resources."
}
