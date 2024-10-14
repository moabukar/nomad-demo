job "fabio" {
  datacenters = ["dc1"]
  type = "system"

  group "fabio" {
    count = 1

    network {
      port "lb" {
        static = 9999
      }
      port "ui" {
        static = 9998
      }
    }

    task "fabio" {
      driver = "docker"

      config {
        image = "fabiolb/fabio"
        network_mode = "host"
        ports = ["lb", "ui"]

        # Set Fabio proxy strategy
        args = [
          "-proxy.strategy=rr",
          "-insecure",
          "-registry.consul.addr=localhost:8500",
          "-log.level=DEBUG"
        ]
      }

      resources {
        cpu    = 200
        memory = 128
      }

      service {
        name = "fabio"
        port = "lb"

        check {
          name     = "fabio-http-check"
          type     = "http"
          path     = "/health"
          interval = "10s"
          timeout  = "2s"
        }
      }

      env {
        CONSUL_HTTP_ADDR = "localhost:8500"
      }
    }
  }
}
