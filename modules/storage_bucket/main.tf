resource "google_storage_bucket" "storage_bucket" {
  name          = var.name
  location      = var.location
  project = var.project
}