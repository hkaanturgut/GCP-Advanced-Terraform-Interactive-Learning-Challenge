variable "name" {
    type = string
  
}

variable "check_interval_sec" {
    type = number
  
}

variable "timeout_sec" {
    type = number
  
}
variable "healthy_threshold" {
    type = number
  
}

variable "unhealthy_threshold" {
    type = number
  
}

variable "http_health_check" {
    type = object({
      request_path =  string
      port= string
    })
  
}

