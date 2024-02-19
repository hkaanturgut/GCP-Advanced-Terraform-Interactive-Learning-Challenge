# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "projects/advanced-terraform-challenge/serviceAccounts/kaant-advanced-terraform-sa@advanced-terraform-challenge.iam.gserviceaccount.com"
resource "google_service_account" "default" {
  account_id                   = "kaant-advanced-terraform-sa"
  create_ignore_already_exists = null
  description                  = null
  disabled                     = false
  display_name                 = "KaanT-Advanced-Terraform-SA"
  project                      = "advanced-terraform-challenge"
  timeouts {
    create = null
  }
}
