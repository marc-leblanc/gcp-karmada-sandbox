resource "google_container_cluster" "primary" {
  count    = var.karmada_gke_count
  name     = "${var.gke_cluster_name}-${count.index}"
  project  = var.gcp_project_id
  location = var.project_zone


  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  initial_node_count = 1
  network            = var.karmada_network
}
