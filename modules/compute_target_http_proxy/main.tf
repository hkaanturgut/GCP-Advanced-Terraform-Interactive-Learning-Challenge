resource "google_compute_target_http_proxy" "default" {
  name    = var.name
  url_map = var.url_map
}