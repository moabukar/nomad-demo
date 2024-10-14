job "consul" {

  datacenters = ["dc1"]

  group "consul" {
    count = 1

    network {
      port "http" {
        static = 8500
      }
      port "dns" {
        static = 8600
      }
    }

    task "consul" {
      driver = "docker"

      config {
        image = "consul:1.15.4"
        args  = ["agent", "-dev", "-client", "0.0.0.0"]
      }

      resources {
        cpu    = 500
        memory = 256
      }
    }
  }
}
