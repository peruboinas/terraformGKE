provider "google" {
  credentials = file("./.json")
  project     = ""
  region      = "us-central1"
  version     = "~> 2.5.0"
}
