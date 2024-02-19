variable "name" {
    type = string
  
}
variable "zone" {
    type = string
  
}
variable "target" {
    type = any
  
}
#autoscaling_policy

variable "autoscaling_policy" {
    type = object({
      max_replicas = number
      min_replicas= number
      cooldown_period= number
      cpu_utilization= object({
        cpu_utilization_target = number
      })
    })
  
}

