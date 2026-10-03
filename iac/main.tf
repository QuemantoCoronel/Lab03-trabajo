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

resource "docker_container" "api_dev" {
  name  = "api-dev"
  image = docker_image.node.image_id
  
  command = ["node", "/app/index.js"]

  ports {
    internal = 3000
    external = 4002
  }

  volumes {
    host_path      = abspath("${path.module}/../backend/index.js")
    container_path = "/app/index.js"
  }

  networks_advanced {
    name = docker_network.dev_network.name
  }
}

resource "docker_container" "web_dev" {
  name  = "web-dev"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = 4001
  }

  volumes {
    host_path      = abspath("${path.module}/../frontend/index.html")
    container_path = "/usr/share/nginx/html/index.html"
  }

  networks_advanced {
    name = docker_network.dev_network.name
  }
}