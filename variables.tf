variable "project_name" {
  description = "Prefix used for Docker resources created by this lab."
  type        = string
  default     = "sdi4213-week12"
}

variable "web_port" {
  description = "Host port for the Week 12 status portal."
  type        = number
  default     = 8080
}

variable "adminer_port" {
  description = "Host port for the Adminer database UI."
  type        = number
  default     = 8081
}

variable "postgres_db" {
  description = "Name of the PostgreSQL database created on first start."
  type        = string
  default     = "helpdesk"
}

variable "postgres_user" {
  description = "PostgreSQL superuser name."
  type        = string
  default     = "student"
}

# No default on purpose: plan/apply fail until terraform.tfvars sets it.
variable "postgres_password" {
  description = "PostgreSQL superuser password, set in the git-ignored terraform.tfvars."
  type        = string
  sensitive   = true
}
