# Настройки провайдера яндекс облака
terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.83.0"
    }
  }
  backend "s3" {
    endpoint                    = "storage.yandexcloud.net"
    bucket                      = "tf-bucket-for-state"
    region                      = "ru-central1-a"
    key                         = "state1/b5pw.tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
  required_version = ">= 0.13"
}
# Настройки авторизации
# Токены лежат во внешнем файле, инициализацию проводить через команду: terraform init -backend-config=${YC_TF_BACKEND}
# Проверка: pre-commit run -a
provider "yandex" {
  service_account_key_file = file("C:/Users/User/yackey.json")
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}