# Модули серверов
module "lamp" {
  source                = "./modules/instance"
  instance_family_image = "lamp"
  vpc_subnet_id         = yandex_vpc_subnet.subnet.id
}

module "lemp" {
  source                = "./modules/instance"
  instance_family_image = "lemp"
  vpc_subnet_id         = yandex_vpc_subnet.subnet.id
}

# Создание сети
resource "yandex_vpc_network" "network" {
  name = "tf-web-network"
}
# Подсеть
resource "yandex_vpc_subnet" "subnet" {
  name           = "tf-subnet-1"
  v4_cidr_blocks = ["192.168.10.0/24"]
  zone           = var.zone
  network_id     = yandex_vpc_network.network.id
}

# Целевая группа
resource "yandex_lb_target_group" "lamp-lemp" {
  name      = "my-target-group"
  region_id = var.zone

  target {
    subnet_id = yandex_vpc_subnet.subnet.id
    address   = module.lamp.internal_ip_address_vm
  }

  target {
    subnet_id = yandex_vpc_subnet.subnet.id
    address   = module.lemp.internal_ip_address_vm
  }
}
# Балансировщик
resource "yandex_lb_network_load_balancer" "lamp-lemp" {
  name        = "my-network-load-balancer"
  description = "balancer for my instances"

  listener {
    name = "lamp-lemp balancer"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.lamp-lemp.id
    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/ping"
      }
    }
  }
}