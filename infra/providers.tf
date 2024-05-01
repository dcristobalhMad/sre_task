provider "civo" {
  token  = var.civo_token
  region = local.cluster_region
}

provider "flux" {
  kubernetes = {
    # Cambiar por el path de tu kubeconfig correcto en la pipeline
    config_path = "./kubeconfig"
  }
  git = {
    url = "ssh://git@github.com/${local.github_org}/${local.github_repository}.git"
    ssh = {
      username    = "git"
      private_key = tls_private_key.flux.private_key_pem
    }
  }
}

provider "github" {
  owner = local.github_org
  token = var.flux_github_token
}
