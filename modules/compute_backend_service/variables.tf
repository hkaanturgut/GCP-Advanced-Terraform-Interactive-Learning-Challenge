variable "name" {
    type = string
  
}
variable "protocol" {
    type = string
  
}
variable "port_name" {
    type = string
}
variable "timeout_sec" {
    type = number
  
}
variable "health_checks" {
    type = list(string)
  
}
variable "backend" {
    type = object({
      group = string
      balancing_mode= string
    })
  
}