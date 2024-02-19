resource "google_compute_subnetwork" "subnet" {
  name          =var.name
  network       = var.network
  region        = var.region
  ip_cidr_range = var.ip_cidr_range
  purpose          = var.purpose
  private_ip_google_access= var.private_ip_google_access
}