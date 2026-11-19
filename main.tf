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

# ---------- WEEK 12 TODO (Milestone 6) ----------
# Extend this configuration with:
# 1. docker_volume.postgres_data
# 2. docker_image.postgres using postgres:18.6-alpine
# 3. docker_container.db attached to docker_network.lab
#    - POSTGRES_DB, POSTGRES_USER, POSTGRES_PASSWORD from variables
#    - mount docker_volume.postgres_data at /var/lib/postgresql/data
# 4. docker_image.adminer using adminer:5.5.1
# 5. docker_container.adminer attached to docker_network.lab
#    - publish internal port 8080 to var.adminer_port
#    - set ADMINER_DEFAULT_SERVER to the database container name
#
# See docs/resource_hints.md for field-level hints. Do not copy real secrets
# into any committed .tf file.
