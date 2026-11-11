resource "yandex_vpc_network" "diploma_net" {
  name = "diploma-network"
}

resource "yandex_vpc_subnet" "public_a" {
  name           = "public-subnet-a"
  zone           = var.zone
  network_id     = yandex_vpc_network.diploma_net.id
  v4_cidr_blocks = ["10.1.0.0/24"]
}

resource "yandex_vpc_subnet" "private_a" {
  name           = "private-subnet-a"
  zone           = var.zone
  network_id     = yandex_vpc_network.diploma_net.id
  v4_cidr_blocks = ["10.2.0.0/24"]
  route_table_id = yandex_vpc_route_table.rt.id
}

resource "yandex_vpc_subnet" "private_b" {
  name           = "private-subnet-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.diploma_net.id
  v4_cidr_blocks = ["10.3.0.0/24"]
  route_table_id = yandex_vpc_route_table.rt.id
}

resource "yandex_vpc_subnet" "private_es" {
  name           = "private-subnet-es"
  zone           = var.zone
  network_id     = yandex_vpc_network.diploma_net.id
  v4_cidr_blocks = ["10.4.0.0/24"]
  route_table_id = yandex_vpc_route_table.rt.id
}

# NAT-шлюз и Route Table
resource "yandex_vpc_gateway" "nat_gateway" {
  name = "nat-gateway"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "rt" {
  name       = "route-table"
  network_id = yandex_vpc_network.diploma_net.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}
