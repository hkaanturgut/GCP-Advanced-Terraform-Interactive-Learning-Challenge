resource "google_compute_network" "vpc_network" {
  project                 = var.project
  name                    = var.name
  auto_create_subnetworks = var.auto_create_subnetworks
  mtu                     = var.mtu
}