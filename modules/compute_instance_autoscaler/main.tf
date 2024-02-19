resource "google_compute_autoscaler" "compute_engine_autoscaler" {
  name   = var.name
  zone   = var.zone
  target = var.target

  autoscaling_policy {
    max_replicas    = var.autoscaling_policy.max_replicas
    min_replicas    = var.autoscaling_policy.min_replicas
    cooldown_period = var.autoscaling_policy.cooldown_period

    cpu_utilization {
      target = var.autoscaling_policy.cpu_utilization.cpu_utilization_target
    }
  }
}