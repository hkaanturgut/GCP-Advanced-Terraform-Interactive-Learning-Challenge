terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.15.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "5.16.0"
    }
  }
  backend "gcs" {
    bucket = "gcp-advanced-project-tfstate-st"
    prefix = "terraform/state"
  }
}

provider "google" {
  credentials = file("pat_to_your_credentials_file")
  project     = "advanced-terraform-challenge"
  region      = "us-central1"
  zone        = "us-central1-a"
}

provider "google-beta" {
  credentials = file("pat_to_your_credentials_file")
  project     = "advanced-terraform-challenge"
  region      = "us-central1"
  zone        = "us-central1-a"
}
