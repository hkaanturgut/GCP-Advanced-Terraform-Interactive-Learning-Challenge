variable "name" {
    type = string
  
}
variable "database_version" {
    type = string
  
}
variable "region" {
    type = string
  
}

variable "settings" {
    type = object({
      tier = string
      deletion_protection_enabled= bool
      ip_configuration=object({
        ipv4_enabled = bool
        private_network= string
        enable_private_path_for_google_cloud_services= bool
      })
    })  
}
