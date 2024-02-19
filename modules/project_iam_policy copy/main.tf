resource "google_project_iam_policy" "project" {
  project     = var.project
  policy_data = var.policy_data
}

