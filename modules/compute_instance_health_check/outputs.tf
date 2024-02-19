# This is where you put your outputs declaration
output "name" {
    value = google_compute_health_check.autohealing.name
  
}

output "id" {
    value = google_compute_health_check.autohealing.id
  
}