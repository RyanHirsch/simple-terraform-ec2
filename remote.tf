terraform {
  backend "s3" {
    bucket               = "hirsch-2018-terraform-state"
    workspace_key_prefix = "workspace"
    key                  = "docker-host.tfstate"
    region               = "us-east-1"
    profile              = "2018"
    encrypt              = true
  }
}
