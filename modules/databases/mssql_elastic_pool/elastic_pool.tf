resource "azurecaf_name" "elasticpool" {

  name          = var.settings.name
  resource_type = "azurerm_mssql_database" //elastic pool naming restriction identical to db
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

resource "azurerm_mssql_elasticpool" "elasticpool" {

  name                = azurecaf_name.elasticpool.result
  resource_group_name = var.server.resource_group_name
  location            = var.server.location
  server_name         = var.server.name
  max_size_gb         = try(var.settings.max_size_gb, null)
  max_size_bytes      = try(var.settings.max_size_bytes, null)
  zone_redundant      = try(var.settings.zone_redundant, null)
  license_type        = try(var.settings.license_type, null)
  tags                = try(var.settings.tags, null)

  sku {
    name     = var.settings.sku.name
    tier     = var.settings.sku.tier
    family   = var.settings.sku.family
    capacity = try(var.settings.sku.capacity, null)
  }

  per_database_settings {
    min_capacity = var.settings.per_database_settings.min_capacity
    max_capacity = var.settings.per_database_settings.max_capacity
  }
}