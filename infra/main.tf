# Create a firewall
resource "civo_firewall" "firewall" {
  name                 = local.firewall_name
  create_default_rules = false
  ingress_rule {
    label      = "kubernetes-api-server"
    protocol   = "tcp"
    port_range = "6443"
    cidr       = ["0.0.0.0/0"]
    action     = "allow"
  }
}

# Create a cluster with k3s
resource "civo_kubernetes_cluster" "demo-cluster" {
  name         = local.cluster_name
  firewall_id  = civo_firewall.firewall.id
  cluster_type = local.cluster_type
  applications = try(local.cluster_applications, "")
  cni          = try(local.cluster_cni, "")
  pools {
    label      = local.cluster_label_nodes
    size       = element(data.civo_size.large.sizes, 0).name
    node_count = local.cluster_nodes
  }
}

# Flux configuration

resource "tls_private_key" "flux" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "github_repository_deploy_key" "this" {
  title      = "Flux"
  repository = local.github_repository
  key        = tls_private_key.flux.public_key_openssh
  read_only  = "false"
}

resource "flux_bootstrap_git" "this" {
  depends_on           = [github_repository_deploy_key.this, civo_kubernetes_cluster.demo-cluster, local_file.kubeconfig]
  log_level            = "info"
  interval             = "1m0s"
  namespace            = "flux-system"
  components           = ["source-controller", "kustomize-controller", "helm-controller", "notification-controller"]
  path                 = "${local.cluster_name}"
  watch_all_namespaces = true
}

resource "local_file" "kubeconfig" {
  depends_on = [civo_kubernetes_cluster.demo-cluster]
  filename   = "./kubeconfig"
  content    = civo_kubernetes_cluster.demo-cluster.kubeconfig
}