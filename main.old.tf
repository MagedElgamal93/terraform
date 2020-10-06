provider "google" {


  credentials = file("terraform-key.json")

  project = "playground-s-11-7e1e4f6b"
  region  = "europe-west1"
  zone    = "europe-west1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

terraform {
  backend "gcs" {
    bucket = "terraformmaged1"
    prefix = "terraform1"
    credentials = "terraform-key.json"
   }
}
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}
resource "google_compute_address" "static_ip" {
  name = "terraform-static-ip"
}
