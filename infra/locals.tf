locals {
  cluster_type         = "k3s"
  cluster_name         = "sre-task-cluster"
  cluster_nodes        = 2
  cluster_node_type    = "g4s.kube.medium"
  cluster_cni          = "cilium"
  cluster_label_nodes  = "flux-pool"
  cluster_region       = "LON1"
  firewall_name        = "cluster-firewall"
  cluster_applications = ""
  #### Flux Configuration ####
  github_org        = "dcristobalhMad"
  github_repository = "sre_task"
}