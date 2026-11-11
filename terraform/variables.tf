variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
}

variable "zone" {
  description = "Default availability zone"
  type        = string
  default     = "ru-central1-a"
}

variable "ssh_public_key" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

# Переменные для доступа к Yandex Cloud (не коммитим в git)
variable "yc_token" {
  description = "Yandex Cloud OAuth token or IAM token"
  type        = string
  sensitive   = true
}

# Пароли для Ansible (будут передаваться в шаблон inventory, но не в открытом виде)
variable "elastic_password" {
  description = "Password for Elasticsearch"
  type        = string
  sensitive   = true
}
