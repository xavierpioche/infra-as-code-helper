terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
//  credentials = file(var.credential_json_file)

  region  = "us-central1"
  zone    = "us-central1-c"
}

