# Tested locally:
## sudo consul agent -dev -client 172.17.0.1 -dns-port 53
## sudo nomad agent -dev -consul-address=172.17.0.1:8500 -bind=172.17.0.1 -network-interface=docker0
job "zookeeper3" {
  datacenters = [
    "dc1"]
  # Run tasks in serial or parallel (1 for serial)
  update {
    max_parallel = 1
  }

  group "zk" {
    count = 3

    restart {
      attempts = 20
      interval = "20m"
      delay = "5s"
      mode = "delay"
    }

    ephemeral_disk {
      migrate = true
      size = "500"
      sticky = true
    }

    task "zk-config-dir" {
      driver = "exec"
      config {
        command = "mkdir"
        args = [
          "-p",
          "/opt/zookeeper/config"]
      }
    }

    task "zk-data-dir" {
      driver = "exec"
      config {
        command = "mkdir"
        args = [
          "-p",
          "/opt/zookeeper/datadir"]
      }
    }

    task "zookeeper" {
      driver = "docker"
      template {
        source = "/etc/nomad.d/jobs/zookeeper/templates/zookeeper-template.tpl"
        destination = "/opt/zookeeper/config/zoo.cfg"
        change_mode = "noop"
      }
      config {
        images = "confluentinc/cp-zookeeper:5.3.1"

        port_map {
          zoo_port = 2181
          zoo_peer1 = 2888
          zoo_peer2 = 3888
        }
        volumes = [
          "/opt/zookeeper/config:/opt/zookeeper/conf",
          "/opt/zookeeper/datadir:/tmp/zookeeper"
        ]
      }
      resources {
        cpu = 100
        memory = 128
        network {
          mbits = 10
          port "zoo_port" {}
          port "zoo_peer1" {}
          port "zoo_peer2" {}
        }
      }
      service {
        tags = [
          "zookeeper"]
        check {
          type = "script"
          name = "zookeeper_docker_check"
          command = "/etc/consul.d/config/zk_check.sh"
          interval = "60s"
          timeout = "5s"
        }
      }
    }
  }
}