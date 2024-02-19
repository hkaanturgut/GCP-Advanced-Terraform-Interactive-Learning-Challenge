variable "name" {
    type = string
  
}
variable "tags" {
    type = list(string)
    default = null
  
}
variable "labels" {
    type = map(string)
    default = null
  
}
variable "instance_description" {
    type = string
    default = null
  
}

variable "machine_type" {
    type = string
  
}
variable "can_ip_forward" {
    type = bool
  
}

variable "scheduling" {
    type = object({
      automatic_restart = bool
      on_host_maintenance= string
    })
    default = null
  
}

variable "disk" {
    type = object({
      source_image =  string
      auto_delete= bool
      boot= bool
      resource_policies= optional(list(string))
    })
  
}

variable "network_interface" {
    type = object({
      network = string
      subnetwork= string
    })
}


variable "service_account" {
    type = object({
      email = string
      scopes= list(string)
    })
    default = null
}