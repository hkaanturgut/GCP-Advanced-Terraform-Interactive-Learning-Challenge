/// *** Virtual Network *** \\\
module "KaanT_VPC" {
  source                  = "./modules/vpc"
  project                 = var.KaanT_VPC.project
  name                    = var.KaanT_VPC.name
  auto_create_subnetworks = var.KaanT_VPC.auto_create_subnetworks
  mtu                     = var.KaanT_VPC.mtu
}

/// *** Public Subnet *** \\\
module "KaanT_Public_Subnet" {
  source        = "./modules/subnet"
  name          = var.KaanT_Public_Subnet.name
  network       = module.KaanT_VPC.id
  region        = var.KaanT_Public_Subnet.region
  ip_cidr_range = var.KaanT_Public_Subnet.ip_cidr_range
  depends_on    = [module.KaanT_VPC]
}

/// *** Firewall for Public Subnet *** \\\
module "KaanT_Firewall" {
  source        = "./modules/firewall"
  name          = var.KaanT_Firewall.name
  network       = module.KaanT_VPC.id
  allow         = var.KaanT_Firewall.allow
  source_ranges = var.KaanT_Firewall.source_ranges
  target_tags   = [module.KaanT_Public_Subnet.name]
  depends_on    = [module.KaanT_Public_Subnet]
}

/// *** Private Subnet *** \\\
module "KaanT_Private_Subnet" {
  source                   = "./modules/subnet"
  name                     = var.KaanT_Private_Subnet.name
  network                  = module.KaanT_VPC.id
  region                   = var.KaanT_Private_Subnet.region
  ip_cidr_range            = var.KaanT_Private_Subnet.ip_cidr_range
  purpose                  = var.KaanT_Private_Subnet.purpose
  private_ip_google_access = var.KaanT_Private_Subnet.private_ip_google_access
  depends_on               = [module.KaanT_VPC]
}

/// *** Router connected to VPC *** \\\
module "KaanT_Router" {
  source                        = "./modules/compute_router"
  name                          = var.KaanT_Router.name
  region                        = module.KaanT_Private_Subnet.region
  network                       = module.KaanT_VPC.id
  encrypted_interconnect_router = var.KaanT_Router.encrypted_interconnect_router
  bgp                           = var.KaanT_Router.bgp
  depends_on                    = [module.KaanT_VPC]
}

# /// *** Router NAT for Private Subnet *** \\\
module "KaanT_Router_NAT" {
  source                             = "./modules/compute_router_nat"
  name                               = var.KaanT_Router_NAT.name
  router                             = module.KaanT_Router.name
  region                             = module.KaanT_Router.region
  nat_ip_allocate_option             = var.KaanT_Router_NAT.nat_ip_allocate_option
  source_subnetwork_ip_ranges_to_nat = var.KaanT_Router_NAT.source_subnetwork_ip_ranges_to_nat
  subnetwork                         = var.KaanT_Router_NAT.subnetwork
  log_config                         = var.KaanT_Router_NAT.log_config
  depends_on                         = [module.KaanT_Private_Subnet, module.KaanT_Router]
}

/// ***  Private IP for SQL Database Instance *** \\\
module "KaanT_SqlDB_Private_Ip_Address" {
  source        = "./modules/compute_global_address"
  name          = var.KaanT_SqlDB_Private_Ip_Address.name
  purpose       = var.KaanT_SqlDB_Private_Ip_Address.purpose
  address_type  = var.KaanT_SqlDB_Private_Ip_Address.address_type
  prefix_length = var.KaanT_SqlDB_Private_Ip_Address.prefix_length
  network       = module.KaanT_VPC.id
  depends_on    = [module.KaanT_VPC]
}


/// *** Service Network Connector *** \\\
module "KaanT_Service_Networking_Connection" {
  source                  = "./modules/service_networking_connection"
  network                 = module.KaanT_VPC.id
  service                 = var.KaanT_Service_Networking_Connection.service
  reserved_peering_ranges = [module.KaanT_SqlDB_Private_Ip_Address.name]
  depends_on              = [module.KaanT_VPC, module.KaanT_SqlDB_Private_Ip_Address]

}