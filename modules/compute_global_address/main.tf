resource "google_compute_global_address" "private_ip_address" {
  provider = google-beta
  name          = var.name
  purpose       = var.purpose
  address_type  = var.address_type
  prefix_length = var.prefix_length
  network       = var.network
}