output "logs" {
  value = concat(
    flatten(data.docker_logs.ctrl_logs.logs_list_string),
    [for k, v in data.docker_logs.mn_logs : flatten(v.logs_list_string)]
  )
}

output "ips" {
  value = concat(
    [
      {
        name = docker_container.control_node.name,
        ip   = docker_container.control_node.network_data[0].ip_address
      }
    ],
    [for k, v in docker_container.managed_nodes : { name = k, ip = v.network_data[0].ip_address }]
  )
}
