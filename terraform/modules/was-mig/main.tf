### WAS Health Check
resource "google_compute_health_check" "was_hc" {
  name                = var.health_check_name
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 3

  tcp_health_check {
    port = 8080
  }
}

### WAS MIG
resource "google_compute_region_instance_group_manager" "was_mig" {
  name               = var.mig_name
  region             = var.region
  base_instance_name = "was"

  version {
    instance_template = var.template_self_link
    name              = "primary"
  }

  target_size = var.mig_size

  auto_healing_policies {
    health_check      = google_compute_health_check.was_hc.self_link
    initial_delay_sec = 60
  }

  named_port {
    name = "http"
    port = 8080
  }
}

