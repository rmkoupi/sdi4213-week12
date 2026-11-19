terraform {
  required_version = ">= 1.13.0"

  required_providers {
    docker = {
      source  = "registry.opentofu.org/kreuzwerker/docker"
      version = "4.6.0"
    }
  }
}
