# Week 12 Resource Hints

These are field-level hints, not a completed solution.

## PostgreSQL volume
Create a `docker_volume` resource. Give it a name derived from `local.prefix`.

## PostgreSQL image
Use a `docker_image` resource with:
- image: `postgres:18.6-alpine`
- `keep_locally = true`

## PostgreSQL container
Use a `docker_container` resource with:
- `image = docker_image.postgres.image_id`
- an `env` set containing `POSTGRES_DB`, `POSTGRES_USER`, and `POSTGRES_PASSWORD`
- `networks_advanced` referencing `docker_network.lab.name`
- a `volumes` block mounting the named volume to `/var/lib/postgresql/data`
- `restart = "unless-stopped"`

A Docker container on a user-defined network can be reached by its container name. Give the database container an easy-to-recognize name such as `${local.prefix}-db`.

## Adminer image
Use `adminer:5.5.1` with `keep_locally = true`.

## Adminer container
Use:
- internal port `8080`
- external port from `var.adminer_port`
- `ADMINER_DEFAULT_SERVER=<database container name>`
- the same Docker network as PostgreSQL

## Output
Add an `adminer_url` output using the Adminer host port.

## Persistence test
After creating a table and row through Adminer, manually remove ONLY the PostgreSQL container with Docker. Do not remove the volume. The next `tofu plan` should detect the missing managed container, and `tofu apply` should recreate it. The database row should remain because the volume was not destroyed.
