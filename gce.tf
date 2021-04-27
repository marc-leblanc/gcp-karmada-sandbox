resource "google_compute_network" "karmada_network" {
  name    = "karmada-network"
  mtu     = 1500
  project = var.gcp_project_id
}

resource "google_compute_firewall" "karmada" {
  name    = "karmada-firewall"
  project = var.gcp_project_id
  network = google_compute_network.karmada_network.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = ["ssh"]
}

resource "google_compute_instance" "karmada" {
  name         = var.gce_name
  machine_type = var.gce_machine_type
  zone         = var.project_zone
  project      = var.gcp_project_id
  scheduling {
    preemptible       = var.gce_preempt
    automatic_restart = false
  }

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = google_compute_network.karmada_network.name

    access_config {
      // Ephemeral IP
    }
  }
  tags = ["ssh"]
  metadata = {
    ssh-keys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
  }

  metadata_startup_script = "echo hi > /test.txt"
  depends_on              = [google_compute_network.karmada_network]
}

resource "template_dir" "ansible_inventory" {
  source_dir      = "./templates/"
  destination_dir = "./ansible-inventory"
  vars = {
    karmada_host = google_compute_instance.karmada.network_interface.0.access_config.0.nat_ip
  }
} 