terraform {
  backend "s3" {
    bucket = "tf-state-remote-civo"
    key    = "terraform-state/sre_task.tfstate"
    region = "us-east-1"
  }

  required_providers {
    civo = {
      source  = "civo/civo"
      version = "1.0.35"
    }
    flux = {
      source  = "fluxcd/flux"
      version = "1.1.2"
    }
    github = {
      source  = "integrations/github"
      version = ">=5.18.0"
    }
  }
}