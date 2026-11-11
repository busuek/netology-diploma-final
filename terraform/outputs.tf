output "bastion_public_ip" {
  value = yandex_compute_instance.bastion.network_interface[0].nat_ip_address
}

# Генерация inventory.ini для Ansible
resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.tmpl", {
    bastion_ip   = yandex_compute_instance.bastion.network_interface[0].nat_ip_address
    web1_fqdn    = yandex_compute_instance.web1.fqdn
    web2_fqdn    = yandex_compute_instance.web2.fqdn
    zabbix_fqdn  = yandex_compute_instance.zabbix.fqdn
    elastic_fqdn = yandex_compute_instance.elasticsearch.fqdn
    kibana_fqdn  = yandex_compute_instance.kibana.fqdn
    elastic_pass = var.elastic_password
  })
  filename = "${path.module}/../ansible/inventory.ini"
}
