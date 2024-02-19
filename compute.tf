import {
  id = "projects/advanced-terraform-challenge/serviceAccounts/kaant-advanced-terraform-sa@advanced-terraform-challenge.iam.gserviceaccount.com"
  to = google_service_account.default
}
data "google_compute_default_service_account" "default" {
}

/// *** Instance Template *** \\\
module "KaanT_Instance_Template" {
  source               = "./modules/compute_instance_template"
  name                 = var.KaanT_Instance_Template.name
  tags                 = var.KaanT_Instance_Template.tags
  labels               = var.KaanT_Instance_Template.labels
  instance_description = var.KaanT_Instance_Template.instance_description
  machine_type         = var.KaanT_Instance_Template.machine_type
  can_ip_forward       = var.KaanT_Instance_Template.can_ip_forward
  disk = {
    source_image = var.KaanT_Instance_Template.disk.source_image
    auto_delete  = var.KaanT_Instance_Template.disk.auto_delete
    boot         = var.KaanT_Instance_Template.disk.boot
  }

  network_interface = {
    network    = module.KaanT_VPC.id
    subnetwork = module.KaanT_Private_Subnet.id

  }
  service_account = {
    email  = data.google_compute_default_service_account.default.email
    scopes = var.KaanT_Instance_Template.service_account.scopes
  }
}


/// *** Compute Health Check *** \\\
module "KaanT_Compute_Health_Check" {
  source              = "./modules/compute_instance_health_check"
  name                = var.KaanT_Compute_Health_Check.name
  check_interval_sec  = var.KaanT_Compute_Health_Check.check_interval_sec
  timeout_sec         = var.KaanT_Compute_Health_Check.timeout_sec
  healthy_threshold   = var.KaanT_Compute_Health_Check.healthy_threshold
  unhealthy_threshold = var.KaanT_Compute_Health_Check.unhealthy_threshold
  http_health_check = {
    request_path = var.KaanT_Compute_Health_Check.http_health_check.request_path
    port         = var.KaanT_Compute_Health_Check.http_health_check.port
  }

}

/// *** Compute Instance Group Manager *** \\\
module "KaanT_Compute_Insrance_Group_Manager" {
  source             = "./modules/compute_instance_group_manager"
  name               = var.KaanT_Compute_Insrance_Group_Manager.name
  base_instance_name = var.KaanT_Compute_Insrance_Group_Manager.base_instance_name
  instance_template  = module.KaanT_Instance_Template.id
  zone               = var.KaanT_Compute_Insrance_Group_Manager.zone
  target_size        = var.KaanT_Compute_Insrance_Group_Manager.target_size
  depends_on         = [var.KaanT_Instance_Template]

}

/// *** Compute Backend Service *** \\\
module "KaanT_Compute_Backend_Service" {
  source        = "./modules/compute_backend_service"
  name          = var.KaanT_Compute_Backend_Service.name
  protocol      = var.KaanT_Compute_Backend_Service.protocol
  port_name     = var.KaanT_Compute_Backend_Service.port_name
  timeout_sec   = var.KaanT_Compute_Backend_Service.timeout_sec
  health_checks = [module.KaanT_Compute_Health_Check.id]
  backend = {
    group          = module.KaanT_Compute_Insrance_Group_Manager.instance_group
    balancing_mode = var.KaanT_Compute_Backend_Service.backend.balancing_mode
  }
  depends_on = [module.KaanT_Compute_Health_Check, module.KaanT_Compute_Insrance_Group_Manager]

}

/// *** Compute Autoscaling *** \\\
module "KaanT_Compute_Autoscaling" {
  source = "./modules/compute_instance_autoscaler"
  name   = var.KaanT_Compute_Autoscaling.name
  zone   = var.KaanT_Compute_Autoscaling.zone
  target = module.KaanT_Compute_Insrance_Group_Manager.id
  autoscaling_policy = {
    max_replicas    = var.KaanT_Compute_Autoscaling.autoscaling_policy.max_replicas
    min_replicas    = var.KaanT_Compute_Autoscaling.autoscaling_policy.min_replicas
    cooldown_period = var.KaanT_Compute_Autoscaling.autoscaling_policy.cooldown_period

    cpu_utilization = {
      cpu_utilization_target = var.KaanT_Compute_Autoscaling.autoscaling_policy.cpu_utilization.cpu_utilization_target
    }
  }
  depends_on = [module.KaanT_Compute_Insrance_Group_Manager]

}

/// *** Compute Url Map *** \\\
module "KaanT_Compute_Url_Map" {
  source          = "./modules/compute_url_map"
  name            = var.KaanT_Compute_Url_Map.name
  default_service = module.KaanT_Compute_Backend_Service.id
  depends_on      = [module.KaanT_Compute_Backend_Service]

}

/// *** Compute Targer Http Proxy *** \\\
module "KaanT_Compute_Target_Http_Proxy" {
  source     = "./modules/compute_target_http_proxy"
  name       = var.KaanT_Compute_Target_Http_Proxy.name
  url_map    = module.KaanT_Compute_Url_Map.id
  depends_on = [module.KaanT_Compute_Url_Map]

}

/// *** Compute Forwarding Rule *** \\\
module "KaanT_Compute_Forwarding_Rule" {
  source     = "./modules/compute_global_forwarding_rule"
  name       = var.KaanT_Compute_Forwarding_Rule.name
  target     = module.KaanT_Compute_Target_Http_Proxy.id
  port_range = var.KaanT_Compute_Forwarding_Rule.port_range
  depends_on = [module.KaanT_Compute_Target_Http_Proxy]

}





