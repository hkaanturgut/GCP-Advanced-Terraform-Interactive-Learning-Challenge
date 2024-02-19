# This is where you put your outputs declaration
output "name" {
    value = google_compute_subnetwork.subnet.name
}

output "region" {
    value = google_compute_subnetwork.subnet.region
  
}

output "id" {
    value = google_compute_subnetwork.subnet.id
  
}