variable "name" {
    type = string
  
}
variable "region" {
    type = string
  
}
variable "network" {
    type = string
  
}
variable "encrypted_interconnect_router" {
    type = bool
  
}
variable "bgp" {
    type = object({
      advertise_mode= string
      asn = number
      keepalive_interval= number
    })
}
