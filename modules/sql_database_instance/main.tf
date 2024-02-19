resource "google_sql_database_instance" "sql_db" {
  name             = var.name
  database_version = var.database_version
  region           = var.region


   settings {
    # Second-generation instance tiers are based on the machine
    # type. See argument reference below.
    tier = var.settings.tier
    deletion_protection_enabled= var.settings.deletion_protection_enabled
    ip_configuration {
      ipv4_enabled                                  = var.settings.ip_configuration.ipv4_enabled
      private_network                               = var.settings.ip_configuration.private_network
      enable_private_path_for_google_cloud_services = var.settings.ip_configuration.enable_private_path_for_google_cloud_services
    }
  }

}