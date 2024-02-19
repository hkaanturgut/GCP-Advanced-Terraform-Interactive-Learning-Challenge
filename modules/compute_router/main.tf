resource "google_compute_router" "router" {
  name    = var.name
  region  = var.region
  network = var.network
  encrypted_interconnect_router = var.encrypted_interconnect_router
  bgp {
    advertise_mode= var.bgp.advertise_mode
    asn = var.bgp.asn
    keepalive_interval= var.bgp.keepalive_interval

}
}