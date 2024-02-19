KaanT_GCP_Project={
    name= "Advanced Terraform Challange"
    labels = {
        environment = "test"
        team       = "devops"
    }
}

gcp_service_list= [
    "compute.googleapis.com",                    # Compute Engine API
    "sqladmin.googleapis.com",                   # Cloud SQL Admin API
    "iam.googleapis.com",                        # Identity and Access Management (IAM) API
    "servicenetworking.googleapis.com",          # Service Networking API
    "cloudresourcemanager.googleapis.com",       # Cloud Resource Manager API
    "oslogin.googleapis.com",                    # Cloud OS Login API
    "iamcredentials.googleapis.com",             # IAM Service Account Credentials API
]

KaanT_Project_TFSTATE_Bucket={
    name = "gcp-advanced-project-tfstate-st"
    location = "us-central1"
}

admin_iam={
    binding={
        role= "roles/owner",
        members= [ "user:you_service_account_email",]
    }
}

compute_networkAdmin={
    binding={
        role= "roles/compute.networkAdmin",
        members= [ "user:you_service_account_email",]
    }
}
