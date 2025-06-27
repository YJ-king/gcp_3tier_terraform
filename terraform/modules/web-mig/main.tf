### Web MIG (Regional)
resource "google_compute_region_instance_group_manager" "web_mig" {
  name               = var.mig_name
  region             = var.region
  base_instance_name = "web"

  version {
    instance_template = var.template_self_link
    name              = "primary"
  }

  target_size = var.mig_size
}

