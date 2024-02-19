# Creates a GCP Project.
resource "google_project" "project" {
  name            = var.name
  project_id      = var.project_id
  billing_account = var.billing_account
  labels          = var.labels
}