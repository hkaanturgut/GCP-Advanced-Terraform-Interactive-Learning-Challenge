resource "google_compute_global_forwarding_rule" "default" {
  name       = var.name
  target     = var.target
  port_range = var.port_range
}