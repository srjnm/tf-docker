resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "nginx-test" {
  for_each = toset(local.names)

  name = each.key
  image = docker_image.nginx.image_id
  ports {
    internal = 80
    external = 3000 + index(local.names, each.key)
  }
  upload {
    file = "/usr/share/nginx/html/index.html"
    content = "<code>${each.key}</code>"
  }
}