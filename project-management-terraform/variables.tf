# Creates a GCP Project
variable "KaanT_GCP_Project" {
    type = object({
      name = string
      labels= map()
    })
  
}

variable "gcp_service_list" {
  description = "List of GCP service to be enabled for a project."
  type        = list(string)
}

variable "KaanT_Project_TFSTATE_Bucket" {
  type = object({
    name = string
    location= string
  })
  
}

variable "admin_iam" {
  type = object({
    binding= object({
      role = string
      members= list(string)
    })
  })
  
}

variable "compute_networkAdmin" {
  type = object({
    binding= object({
      role = string
      members= list(string)
    })
  })
  
}
