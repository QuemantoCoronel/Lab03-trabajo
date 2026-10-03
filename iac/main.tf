terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {
}

resource "docker_image" "nginx" {
  name         = "nginx:alpine"
  keep_locally = false
}

resource "docker_image" "node" {
  name         = "node:18-alpine"
  keep_locally = false
}

resource "docker_image" "postgres" {
  name         = "postgres:15-alpine"
  keep_locally = false
}

resource "docker_network" "dev_network" {
  name = "dev_network"
}

resource "docker_container" "bd_dev" {
  name  = "bd-dev"
  image = docker_image.postgres.image_id

  env = [
    "POSTGRES_USER=admin",
    "POSTGRES_PASSWORD=admin",
    "POSTGRES_DB=bd"
  ]

  ports {
    internal = 5432
    external = 4003
  }

  networks_advanced {
    name = docker_network.dev_network.name
  }
}