resource "google_service_networking_connection" "private_vpc_connection" {
  provider = google-beta

  network                 = var.network
  service                 = var.service
  reserved_peering_ranges = var.reserved_peering_ranges
}