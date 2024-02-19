#------------------------------------------------- NETWORKING RESOURCES VALUES -------------------------------------------------#

/// *** Virtual Network *** \\\
KaanT_VPC = {
  project                 = "advanced-terraform-challenge"
  name                    = "kaant-vpc-network"
  auto_create_subnetworks = false
  mtu                     = 1300
}

/// *** Public Subnet *** \\\
KaanT_Public_Subnet = {
  name          = "kaant-public-subnet"
  region        = "us-central1"
  ip_cidr_range = "10.0.1.0/24"
  purpose       = "PUBLIC"
}

/// *** Firewall for Public Subnet *** \\\
KaanT_Firewall = {
  name = "kaant-firewall"
  allow = {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
  source_ranges = ["0.0.0.0/0"]
}

/// *** Private Subnet *** \\\
KaanT_Private_Subnet = {
  name                     = "kaant-private-subnet"
  region                   = "us-central1"
  ip_cidr_range            = "10.0.2.0/24"
  purpose                  = "PRIVATE"
  private_ip_google_access = true
}

/// *** Router connected to VPC *** \\\
KaanT_Router = {
  name                          = "kaant-router"
  encrypted_interconnect_router = true
  bgp = {
    advertise_mode     = "DEFAULT"
    asn                = 64514
    keepalive_interval = 20
  }
}

/// *** Router NAT for Private Subnet *** \\\
KaanT_Router_NAT = {
  name                               = "kaant-router-nat"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork = {
    name                    = "kaant-private-subnet"
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
  log_config = {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

/// *** Private IP for SQL Database Instance *** \\\
KaanT_SqlDB_Private_Ip_Address = {
  name          = "kaant-sqldb-private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
}


/// *** Service Network Connector *** \\\
KaanT_Service_Networking_Connection = {
  service = "servicenetworking.googleapis.com"
}

#------------------------------------------------- COMPUTING RESOURCES VALUES -------------------------------------------------#

/// *** Instance Template *** \\\
KaanT_Instance_Template = {
  name = "kaant-instance-template"
  tags = ["foo", "bar"]
  labels = {
    environment = "dev"
  }
  instance_description = "This template is used to create app server instances."
  machine_type         = "e2-medium"
  can_ip_forward       = false
  disk = {
    source_image = "debian-cloud/debian-11"
    auto_delete  = true
    boot         = true

  }
  service_account = {
    scopes = ["cloud-platform"]
  }

}

/// *** Compute Health Check *** \\\
KaanT_Compute_Health_Check = {
  name                = "kaant-compute-health-check"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10
  http_health_check = {
    request_path = "/healthz"
    port         = "80"
  }
}

/// *** Compute Instance Group Manager *** \\\
KaanT_Compute_Insrance_Group_Manager = {
  name               = "kaant-compute-insrance-group-manager"
  base_instance_name = "app"
  zone               = "us-central1-a"
  target_size        = 2
}

/// *** Compute Backend Service *** \\\
KaanT_Compute_Backend_Service = {
  name        = "kaant-compute-backend-service"
  protocol    = "HTTP"
  port_name   = "http"
  timeout_sec = 10
  backend = ({
    balancing_mode = "UTILIZATION"
  })
}

/// *** Compute Autoscaling *** \\\
KaanT_Compute_Autoscaling = {
  name = "kaant-compute-autoscaling"
  zone = "us-central1-a"
  autoscaling_policy = {
    max_replicas    = 5
    min_replicas    = 2
    cooldown_period = 60
    cpu_utilization = {
      cpu_utilization_target = 0.5
    }
  }
}


/// *** Compute Url Map *** \\\
KaanT_Compute_Url_Map = {
  name = "kaant-compute-url-map"
}

/// *** Compute Targer Http Proxy *** \\\
KaanT_Compute_Target_Http_Proxy = {
  name = "kaant-compute-target-http-proxy"
}

/// *** Compute Forwarding Rule *** \\\
KaanT_Compute_Forwarding_Rule = {
  name       = "kaant-compute-forwarding-rule"
  port_range = "80"
}


#------------------------------------------------- DATABASE RESOURCES VALUES -------------------------------------------------#

/// *** SQL Database Instance *** \\\
KaanT_Sql_DB_Instance = {
  name             = "kaant-sql-db-instance"
  database_version = "POSTGRES_15"
  settings = {
    tier                        = "db-f1-micro"
    deletion_protection_enabled = false
    ip_configuration = {
      ipv4_enabled                                  = false
      enable_private_path_for_google_cloud_services = true
    }
  }
}

