locals {
  prefix = var.project_name
}

# ---------- Starter infrastructure: network + status portal ----------
resource "docker_network" "lab" {
  name = "${local.prefix}-network"
}

resource "docker_image" "nginx" {
  name         = "nginx:1.30.6-alpine-slim"
  keep_locally = true
}

resource "docker_container" "web" {
  name  = "${local.prefix}-web"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = var.web_port
  }

  networks_advanced {
    name = docker_network.lab.name
  }

  volumes {
    host_path      = abspath("${path.module}/site")
    container_path = "/usr/share/nginx/html"
    read_only      = true
  }

  restart = "unless-stopped"
}

# ---------- Week 12: PostgreSQL + persistent volume + Adminer ----------
# The volume is its own resource, so removing the db container (drift test)
# leaves the data in place; only `tofu destroy` removes it.
resource "docker_volume" "postgres_data" {
  name = "${local.prefix}-pgdata"
}

resource "docker_image" "postgres" {
  name         = "postgres:18.6-alpine"
  keep_locally = true
}

resource "docker_container" "db" {
  name  = "${local.prefix}-db"
  image = docker_image.postgres.image_id

  # Values come from terraform.tfvars (git-ignored); no secret in this file.
  env = [
    "POSTGRES_DB=${var.postgres_db}",
    "POSTGRES_USER=${var.postgres_user}",
    "POSTGRES_PASSWORD=${var.postgres_password}",
  ]

  networks_advanced {
    name = docker_network.lab.name
  }

  # postgres 18+ keeps PGDATA at /var/lib/postgresql/18/docker and refuses
  # to start if a mount sits at /var/lib/postgresql/data (the pre-18 path
  # given in docs/resource_hints.md). Mount the parent instead.
  volumes {
    volume_name    = docker_volume.postgres_data.name
    container_path = "/var/lib/postgresql"
  }

  restart = "unless-stopped"
}

resource "docker_image" "adminer" {
  name         = "adminer:5.5.1"
  keep_locally = true
}

resource "docker_container" "adminer" {
  name  = "${local.prefix}-adminer"
  image = docker_image.adminer.image_id

  # Containers on a user-defined network resolve each other by name.
  env = [
    "ADMINER_DEFAULT_SERVER=${docker_container.db.name}",
  ]

  ports {
    internal = 8080
    external = var.adminer_port
  }

  networks_advanced {
    name = docker_network.lab.name
  }

  restart = "unless-stopped"
}
