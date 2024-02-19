# Read Google Cloud Compoute(GCP) billing account id.
data "google_billing_account" "account" {
  display_name = "My Billing Account"
  open         = true
}


# Creates a GCP Project
module "KaanT_GCP_Project" {
    source = "../modules/project"
    name= var.KaanT_GCP_Project.name
    project_id= lowercase(var.KaanT_GCP_Project.name)
    billing_account= data.google_billing_account.account.id
    labels= var.KaanT_GCP_Project.labels
}

# Enable services in newly created GCP Project.
resource "google_project_service" "gcp_services" {
  count   = length(var.gcp_service_list)
  project = google_project.KaanT_GCP_Project.project_id
  service = var.gcp_service_list[count.index]

  disable_dependent_services = true
}

# Creates a GCS bucket to store tfstate.
module "KaanT_Project_TFSTATE_Bucket" {
    source = "../modules/storage_bucket"
    name= var.KaanT_Project_TFSTATE_Bucket.name
    location= var.KaanT_Project_TFSTATE_Bucket.location
    project = module.KaanT_GCP_Project.id
  
}