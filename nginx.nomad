job "nginx" {
  datacenters = ["dc1"]

  group "nginx" {
    count = 1

    task "nginx" {
      driver = "docker"

      config {
        image = "nginx:latest"
        ports = ["http"]
      }

      resources {
        cpu    = 500 # 500 MHz
        memory = 256 # 256MB
      }

      service {
        name = "nginx"
        port = "http"

        check {
          name     = "nginx alive"
          type     = "http"
          path     = "/"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }

    network {
      port "http" {
        static = 8080
      }
    }
  }
}
