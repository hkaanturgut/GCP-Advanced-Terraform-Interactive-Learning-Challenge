resource "google_compute_url_map" "default" {
  name            = var.name
  default_service = var.default_service
}