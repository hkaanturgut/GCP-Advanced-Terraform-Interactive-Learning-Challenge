variable "name" {
    type = string
    default = null
  
}
variable "project_id" {
    type = any
  
}
variable "billing_account" {
    type = string
    default = null
  
}
variable "labels" {
    type = map(string)
  
}
