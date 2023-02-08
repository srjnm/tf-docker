resource "docker_image" "nginx" {
  name = "srjnm/managed-nginx:v2"
}

resource "docker_image" "ubuntu" {
  name = "srjnm/control-ubuntu:v1"
}

resource "docker_container" "control_node" {
  name  = "control"
  image = docker_image.ubuntu.image_id

  ports {
    internal = 22
    external = 50000
  }

  networks_advanced {
    name = docker_network.bridge.id
  }
}

resource "docker_container" "managed_nodes" {
  for_each = toset(local.names)

  name  = each.key
  image = docker_image.nginx.image_id
  ports {
    internal = 80
    external = 3000 + index(local.names, each.key)
  }

  networks_advanced {
    name = docker_network.bridge.id
  }

  upload {
    file    = "/usr/share/nginx/html/index.html"
    content = "<code>${each.key}</code>"
  }
}

resource "docker_network" "bridge" {
  name   = "ansible_network"
  driver = "bridge"

  ipam_config {
    subnet = "10.20.0.0/29"
  }
}

resource "local_file" "ansible_hosts" {
  filename = "../../ansible-test/config-n-hosts/hosts"
  content = join("\n", flatten(
    [
      "[control]",
      "localhost",
      "[control:vars]",
      "ansible_user=control",
      "ansible_password=passwd",
      "ansible_connection=ssh",
      "ansible_port=50000",
      "ansible_ssh_common_args='-o StrictHostKeyChecking=no'",
      "",
      "[managed]",
      [for k, v in docker_container.managed_nodes : v.network_data[0].ip_address],
      "[managed:vars]",
      "ansible_user=managed",
      "ansible_password=passwd",
      "ansible_connection=ssh",
      "ansible_ssh_common_args='-o StrictHostKeyChecking=no'"
    ]
  ))
}
