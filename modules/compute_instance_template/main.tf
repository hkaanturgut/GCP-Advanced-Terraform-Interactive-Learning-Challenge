resource "google_compute_instance_template" "default" {
  name        = var.name

  tags = var.tags

  labels = var.labels

  instance_description = var.instance_description
  machine_type         = var.machine_type
  can_ip_forward       = var.can_ip_forward


  dynamic "scheduling" {
    for_each = var.scheduling != null ? [1] : []

    content {
      automatic_restart= var.scheduling.automatic_restart
      on_host_maintenance= var.scheduling.on_host_maintenance
    }
  }

  // Create a new boot disk from an image
  dynamic "disk" {
    for_each = var.disk != null ? [1] : []

    content {
      source_image= var.disk.source_image
      auto_delete= var.disk.auto_delete
      boot= var.disk.boot
      resource_policies= var.disk.resource_policies
    }
    
  }

  network_interface {
    network = var.network_interface.network
    subnetwork = var.network_interface.subnetwork 
  }

  lifecycle {
    create_before_destroy = true
  }

  
  dynamic "service_account" {
    for_each = var.service_account !=null ? [1] : []

    content {
      email= var.service_account.email
      scopes=var.service_account.scopes
    }
    
  }

}