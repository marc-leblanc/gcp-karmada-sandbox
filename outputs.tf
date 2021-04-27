output "karmada_gce_host" {

  value = {
    ip          = google_compute_instance.karmada.network_interface.0.access_config.0.nat_ip
    preemptible = var.gce_preempt
    ssh_user    = var.gce_ssh_user
    ssh_pub_key = var.gce_ssh_pub_key_file
    ssh_command = "ssh ${var.gce_ssh_user}@${google_compute_instance.karmada.network_interface.0.access_config.0.nat_ip} -i ${var.gce_ssh_pub_key_file}"
  }
}