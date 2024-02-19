resource "google_compute_instance_group_manager" "instance_group_manager" {
  name               = var.name
  base_instance_name = var.base_instance_name
  version {
    instance_template  = var.instance_template
  }
  zone               = var.zone
  target_size        = var.target_size
}