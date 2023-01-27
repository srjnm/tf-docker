resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "nginx" {
  for_each = toset(local.names)

  name  = each.key
  image = docker_image.nginx.image_id
  ports {
    internal = 80
    external = 3000 + index(local.names, each.key)
  }
  upload {
    file    = "/usr/share/nginx/html/index.html"
    content = "<code>${each.key}</code>"
  }
}

resource "local_file" "ansible_hosts" {
  filename = "../../ansible-test/config-n-hosts/hosts"
  content  = join("\n", flatten(["[nginx]", [for k, v in docker_container.nginx : v.network_data[0].ip_address]]))
}
