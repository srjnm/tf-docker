data "docker_logs" "nginx_logs" {
  for_each = toset(local.names)
  name     = docker_container.nginx[each.key].name
}
