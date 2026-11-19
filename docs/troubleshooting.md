# Week 12 Troubleshooting

## `tofu` is not recognized
Verify installation with `tofu -version`. On Windows, confirm the WinGet links directory is on PATH if necessary.

## OpenTofu cannot reach Docker
Start Docker Desktop / Docker Engine and verify `docker version` works before running `tofu plan` or `tofu apply`.

## `tofu plan` says initialization is required
Run `tofu init`. Re-run it after changing provider requirements.

## Port already in use
Change `web_port` or `adminer_port` in `terraform.tfvars`, then run `tofu plan` and review the proposed change.

## Formatting check fails in GitHub Actions
Run `tofu fmt -recursive`, commit the changed files, and push again.

## Adminer cannot connect to PostgreSQL
Confirm both containers are attached to the same Docker network, the server name matches the database container name, and the user/database/password values match.

## Database data disappeared during drift test
The volume was probably removed along with the container. For the drift milestone, remove only the PostgreSQL container, not the managed Docker volume.

## `tofu destroy` will remove the database volume
Correct. The final destroy milestone intentionally removes all resources managed by this configuration, including the volume and its data.
