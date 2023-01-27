output "logs" {
  value = [for k, v in data.docker_logs.nginx_logs : flatten(v.logs_list_string)]
}

output "ips" {
  value = [for k, v in docker_container.nginx : { name = k, ip = v.network_data[0].ip_address }]
}
