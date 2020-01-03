consul {
  address = "172.17.0.1:8500"
}

template {
  source = "/etc/nomad.d/jobs/zookeeper/templates/zoo.tpl"
  destination = "/etc/nginx/conf.d/default.conf"
  command = "/etc/init.d/nginx reload"
  command_timeout = "60s"
}