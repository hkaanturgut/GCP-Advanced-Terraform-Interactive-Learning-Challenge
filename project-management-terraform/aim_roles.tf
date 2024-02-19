/// *** Existing Users data *** \\\
data "google_iam_policy" "admin" {
  binding {
    role = var.admin_iam.binding.role
    members = var.admin_iam.binding.members
    
  }
}

data "google_iam_policy" "compute_networkAdmin" {
  binding {
    role = var.compute_networkAdmin.binding.role
    members = var.compute_networkAdmin.binding.members
    
  }
}

/// *** IAM OWNER Policy Data *** \\\
module "KaanT_Project_IAM_Policy" {
    source = "./modules/project_iam_policy"
    project= module.KaanT_GCP_Project.id
    policy_data= data.google_iam_policy.admin.policy_data
  
}

/// *** IAM Network Admin Policy Data *** \\\
module "KaanT_Project_NetworkAdmin_IAM_Policy" {
    source = "./modules/project_iam_policy"
    project= module.KaanT_GCP_Project.id
    policy_data= data.google_iam_policy.compute_networkAdmin.policy_data
  
}