variable "name" {
    type = string
    default = null
  
}
variable "network" {
    type = any
  
}
variable "ip_cidr_range" {
    type = string
    default = null
  
}
variable "region" {
    type = string
  
}
variable "purpose" {
    type = string
    default = null
}
variable "private_ip_google_access" {
    type = bool
    default = null
}
