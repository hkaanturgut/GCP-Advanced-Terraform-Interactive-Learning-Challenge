/// *** SQL Database Instance *** \\\
module "KaanT_Sql_DB_Instance" {
  source           = "./modules/sql_database_instance"
  name             = var.KaanT_Sql_DB_Instance.name
  database_version = var.KaanT_Sql_DB_Instance.database_version
  region           = module.KaanT_Private_Subnet.region
  depends_on       = [module.KaanT_Service_Networking_Connection]
  settings = {
    tier                        = var.KaanT_Sql_DB_Instance.settings.tier
    deletion_protection_enabled = var.KaanT_Sql_DB_Instance.settings.deletion_protection_enabled
    ip_configuration = {
      ipv4_enabled                                  = var.KaanT_Sql_DB_Instance.settings.ip_configuration.ipv4_enabled
      private_network                               = module.KaanT_VPC.id
      enable_private_path_for_google_cloud_services = var.KaanT_Sql_DB_Instance.settings.ip_configuration.enable_private_path_for_google_cloud_services
    }
  }

}
