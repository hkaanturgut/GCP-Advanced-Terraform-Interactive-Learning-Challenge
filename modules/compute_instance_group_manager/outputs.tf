# This is where you put your outputs declaration
output "id" {
    value = google_compute_instance_group_manager.instance_group_manager.id
  
}

output "instance_group" {
    value = google_compute_instance_group_manager.instance_group_manager.instance_group
  
}