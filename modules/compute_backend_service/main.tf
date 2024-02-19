resource "google_compute_backend_service" "default" {
  name        = var.name
  protocol    = var.protocol
  port_name   = var.port_name
  timeout_sec = var.timeout_sec
  health_checks = var.health_checks

  backend {
    group = var.backend.group
    balancing_mode=var.backend.balancing_mode
  }
}