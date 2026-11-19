output "portal_url" {
  description = "URL for the Week 12 status portal."
  value       = "http://localhost:${var.web_port}"
}

output "adminer_url" {
  description = "URL for the Adminer database UI."
  value       = "http://localhost:${var.adminer_port}"
}

output "db_server" {
  description = "Server name to enter in Adminer (the database container name)."
  value       = docker_container.db.name
}
