#------------------------------------------------- NETWORKING RESOURCES VARIABLES -------------------------------------------------#

/// *** Variable for Virtual Network *** \\\
variable "KaanT_VPC" {
  type = object({
    project                 = string
    name                    = string
    auto_create_subnetworks = bool
    mtu                     = number
  })
}

/// *** Variable for Public Subnet *** \\\
variable "KaanT_Public_Subnet" {
  type = object({
    name          = string
    region        = string
    ip_cidr_range = string

  })
}

/// *** Variable for Firewall for Public Subnet *** \\\
variable "KaanT_Firewall" {
  type = object({
    name = string
    allow = object({
      protocol = string
      ports    = list(string)
    })
    source_ranges = list(string)
  })

}

/// *** Variables for Private Subnet *** \\\
variable "KaanT_Private_Subnet" {
  type = object({
    name                     = string
    region                   = string
    ip_cidr_range            = string
    purpose                  = string
    private_ip_google_access = bool

  })
}

/// *** Variables for Router connected to VPC *** \\\
variable "KaanT_Router" {
  type = object({
    name                          = string
    encrypted_interconnect_router = bool
    bgp = object({
      advertise_mode     = string
      asn                = number
      keepalive_interval = number
    })
  })

}

/// *** Variables Router NAT for Private Subnet *** \\\
variable "KaanT_Router_NAT" {
  type = object({
    name                               = string
    nat_ip_allocate_option             = string
    source_subnetwork_ip_ranges_to_nat = string
    log_config = object({
      enable = bool
      filter = string
    })
    subnetwork = object({
      name                    = string
      source_ip_ranges_to_nat = list(string)
    })
  })

}

/// ***  Variables for Private IP for SQL Database Instance *** \\\
variable "KaanT_SqlDB_Private_Ip_Address" {
  type = object({
    name          = string
    purpose       = string
    address_type  = string
    prefix_length = number
  })
}

/// *** Variables for Service Network Connector *** \\\
variable "KaanT_Service_Networking_Connection" {
  type = object({
    service = string
  })

}

#------------------------------------------------- COMPUTING RESOURCES VARIABLES -------------------------------------------------#

/// *** Instance Template *** \\\
variable "KaanT_Instance_Template" {
  type = object({
    name                 = string
    tags                 = list(string)
    labels               = map(string)
    instance_description = string
    machine_type         = string
    can_ip_forward       = bool
    disk = object({
      source_image = string
      auto_delete  = bool
      boot         = bool
    })
    service_account = object({
      # email = string
      scopes = list(string)
    })
  })

}

/// *** Compute Health Check *** \\\
variable "KaanT_Compute_Health_Check" {
  type = object({
    name                = string
    check_interval_sec  = number
    timeout_sec         = number
    check_interval_sec  = number
    healthy_threshold   = number
    unhealthy_threshold = number
    http_health_check = object({
      request_path = string
      port         = string
    })
  })

}

/// *** Compute Instance Group Manager *** \\\
variable "KaanT_Compute_Insrance_Group_Manager" {
  type = object({
    name               = string
    base_instance_name = string
    zone               = string
    target_size        = number
  })

}


/// *** Compute Backend Service *** \\\
variable "KaanT_Compute_Backend_Service" {
  type = object({
    name        = string
    protocol    = string
    port_name   = string
    timeout_sec = number
    backend = object({
      balancing_mode = string
    })
  })

}

/// *** Compute Autoscaling *** \\\
variable "KaanT_Compute_Autoscaling" {
  type = object({
    name = string
    zone = string
    autoscaling_policy = object({
      max_replicas    = number
      min_replicas    = number
      cooldown_period = number
      cpu_utilization = object({
        cpu_utilization_target = number
      })
    })

  })

}


/// *** Compute Url Map *** \\\
variable "KaanT_Compute_Url_Map" {
  type = object({
    name = string
  })

}

/// *** Compute Targer Http Proxy *** \\\
variable "KaanT_Compute_Target_Http_Proxy" {
  type = object({
    name = string
  })

}

/// *** Compute Forwarding Rule *** \\\
variable "KaanT_Compute_Forwarding_Rule" {
  type = object({
    name       = string
    port_range = string
  })

}

#------------------------------------------------- DATABASE RESOURCES VARIABLES -------------------------------------------------#

/// *** SQL Database Instance *** \\\
variable "KaanT_Sql_DB_Instance" {
  type = object({
    name             = string
    database_version = string
    settings = object({
      tier                        = string
      deletion_protection_enabled = bool
      ip_configuration = object({
        ipv4_enabled                                  = bool
        enable_private_path_for_google_cloud_services = bool
      })
    })
  })

}


