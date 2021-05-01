variable "gcp_project_id" {
  description = "GCP Project to be used for deployment"
}

variable "gce_name" {
  description = "Name of the Karmada GCE Instance"
  default     = "karmada"
}

variable "gke_cluster_name" {
  description = "Name of the GKE Cluster"
  default     = "member-cluster"
}

variable "gce_machine_type" {
  description = "Machine type for the Karmada GCE host"
  default     = "n1-standard-2"
}

variable "gce_preempt" {
  description = "Enable pre-emptible host for Karmada"
  default     = true
}

variable "gce_ssh_pub_key_file" {
  description = "Path to SSH Pub Key file"
}

variable "gce_ssh_user" {
  description = "Username for SSH to GCE instance"
}
variable "project_zone" {
  description = "Zone for GCE/GKE"
  default     = "northamerica-northeast1-a"
}

variable "karmada_install" {
  description = "True/False install Karmada after host build"
  default     = true
}

variable "karmada_network" {
  description = "Network name for Karmada"
  default     = "karmada-network"
}

variable "karmada_gke_count" {
  description = "Number of Member clusters to build"
  default     = 1
<<<<<<< HEAD
=======

>>>>>>> 2e40574519e5eec49133204a87930aa8cd1abc2c
}
