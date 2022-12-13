# Внутренний ip виртуалки lamp
output "internal_ip_address_lamp" {
  value = module.lamp.internal_ip_address_vm
}
# Внешний ip виртуалки lamp
output "external_ip_address_lamp" {
  value = module.lamp.external_ip_address_vm
}
# Внутренний ip виртуалки lemp
output "internal_ip_address_lemp" {
  value = module.lemp.internal_ip_address_vm
}
# Внешний ip виртуалки lemp
output "external_ip_address_lemp" {
  value = module.lemp.external_ip_address_vm
}
