resource "google_compute_health_check" "autohealing" {
  name                = var.name
  check_interval_sec  = var.check_interval_sec
  timeout_sec         = var.timeout_sec
  healthy_threshold   = var.check_interval_sec
  unhealthy_threshold = var.unhealthy_threshold

  http_health_check {
    request_path = var.http_health_check.request_path
    port         = var.http_health_check.port
  }
}