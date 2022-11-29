# Terraform azurerm resource: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_consumer_group

data "azurecaf_name" "iothub_consumer_group" {
  name          = var.settings.name
  resource_type = "azurerm_iothub_consumer_group"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_iothub_consumer_group" "iothubconsumergroup" {
  name                   = data.azurecaf_name.iothub_consumer_group.result
  iothub_name            = var.iothub_name
  resource_group_name    = var.resource_group_name
  eventhub_endpoint_name = var.settings.eventhub_endpoint_name
}