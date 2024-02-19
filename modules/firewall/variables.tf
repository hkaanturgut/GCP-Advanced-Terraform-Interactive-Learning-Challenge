variable "name" {
    type = string
    default = null
  
}
variable "network" {
    type = string
  
}
variable "allow" {
    type = object({
      protocol = string
      ports= list(string)
    })
  
}
variable "source_ranges" {
    type = list(string)
    default = null
  
}
variable "target_tags" {
    type = list(string)
  
}
