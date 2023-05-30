output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "container_registry_id" {
  value = azurerm_container_registry.acr.id
}

output "container_registry_login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "container_registry_admin_username" {
  value = azurerm_container_registry.acr.admin_username
}

output "container_registry_admin_password" {
  value = azurerm_container_registry.acr.admin_password
  sensitive = true
}
