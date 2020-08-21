# Specify the GCP Provider
provider "google" {
credentials = "${file("data-fabric-274409-35f7b1f74678.json")}"
project = "data-fabric-274409"
region = "us-central1"
}

# Create a GKE cluster
resource "google_container_cluster" "my_k8s_cluster" {
  provider           = "${var.provider}"
  name               = "my-k8s-cluster"
  location           = "${var.region}"
  initial_node_count = 1

  master_auth {
    username = ""
    password = ""
  }

  # Enable Workload Identity
  workload_identity_config {
    identity_namespace = "${var.project_id}.svc.id.goog"
  }

  node_config {
    machine_type = "${var.machine_type}"
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    metadata = {
      "disable-legacy-endpoints" = "true"
    }

    workload_metadata_config {
      node_metadata = "GKE_METADATA_SERVER"
    }

    labels = { # Update: Replace with desired labels
      "environment" = "test"
      "team"        = "devops"
    }
  }
}
