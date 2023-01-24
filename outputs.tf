output "logs" {
  value = [ for k, v in data.docker_logs.nginx_logs : flatten(v.logs_list_string) ]
}