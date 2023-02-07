data "docker_logs" "ctrl_logs" {
  name = docker_container.control_node.name
}

data "docker_logs" "mn_logs" {
  for_each = toset(local.names)
  name     = docker_container.managed_nodes[each.key].name
}
