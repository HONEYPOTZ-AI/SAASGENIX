
provider "google" {
  project = "saasgenix-project"
  region  = "us-central1"
}

resource "google_container_registry" "saasgenix_gcr" {
  name     = "saasgenix-gcr"
  location = "us"
}

resource "google_container_cluster" "saasgenix_gke" {
  name     = "saasgenix-gke"
  location = "us-central1"
  initial_node_count = 2

  node_config {
    machine_type = "e2-medium"
  }
}

resource "google_compute_network" "saasgenix_network" {
  name = "saasgenix-network"
}
