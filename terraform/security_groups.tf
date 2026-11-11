resource "yandex_vpc_security_group" "sg_bastion" {
  name       = "sg-bastion"
  network_id = yandex_vpc_network.diploma_net.id

  ingress {
    protocol       = "TCP"
    description    = "SSH"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "sg_web" {
  name       = "sg-web"
  network_id = yandex_vpc_network.diploma_net.id

  ingress {
    protocol       = "TCP"
    description    = "HTTP from ALB"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol       = "TCP"
    description    = "SSH from bastion"
    port           = 22
    v4_cidr_blocks = ["10.1.0.0/24"]
  }
  ingress {
    protocol       = "TCP"
    description    = "Zabbix agent"
    port           = 10050
    v4_cidr_blocks = ["10.1.0.0/24"]
  }
  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "sg_elastic" {
  name       = "sg-elasticsearch"
  network_id = yandex_vpc_network.diploma_net.id

  ingress {
    protocol       = "TCP"
    description    = "Elasticsearch"
    port           = 9200
    v4_cidr_blocks = ["10.0.0.0/8"]
  }
  ingress {
    protocol       = "TCP"
    description    = "SSH from bastion"
    port           = 22
    v4_cidr_blocks = ["10.1.0.0/24"]
  }
  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "sg_kibana" {
  name       = "sg-kibana"
  network_id = yandex_vpc_network.diploma_net.id

  ingress {
    protocol       = "TCP"
    description    = "Kibana Web"
    port           = 5601
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol       = "TCP"
    description    = "SSH"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "sg_zabbix" {
  name       = "sg-zabbix"
  network_id = yandex_vpc_network.diploma_net.id

  ingress {
    protocol       = "TCP"
    description    = "Zabbix Web"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol       = "TCP"
    description    = "SSH"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
