provider "google" {
credentials = "${file("data-fabric-274409-35f7b1f74678.json")}"
project = "data-fabric-274409"
region = "us-central1"
}
