resource "google_container_cluster" "primary" {
  count              = var.karmada_gke_count
  name               = "${var.gke_cluster_name}-${count.index}"
  project            = var.gcp_project_id
  location           = var.project_zone
  initial_node_count = 1
  network            = var.karmada_network
}
