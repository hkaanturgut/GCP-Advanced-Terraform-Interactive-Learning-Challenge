variable "name" {
    type = string
  
}
variable "router" {
    type = any
  
}
variable "region" {
    type = string
  
}
variable "nat_ip_allocate_option" {
    type = string
  
}
variable "source_subnetwork_ip_ranges_to_nat" {
    type = string
  
}

variable "subnetwork" {
    type = object({
      name = string
      source_ip_ranges_to_nat= list(string)
    })
    default = null
  
}
variable "log_config" {
    type = object({
      enable = bool
      filter= string
    })
  
}