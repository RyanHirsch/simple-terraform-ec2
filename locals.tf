locals {
  name   = "docker-host"
  prefix = "${terraform.workspace}-${local.name}"
}
