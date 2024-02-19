resource "google_compute_target_pool" "default" {
  name = var.name

  instances = var.instances
}