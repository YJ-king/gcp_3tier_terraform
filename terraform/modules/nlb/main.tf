### WAS MIG → Instance Group 조회
data "google_compute_region_instance_group" "was_group" {
  name   = var.was_mig_name
  region = var.region
}

### Backend Service
resource "google_compute_region_backend_service" "was_backend" {
  name                  = var.backend_service_name
  region                = var.region
  protocol              = "TCP"
  load_balancing_scheme = "INTERNAL"
  timeout_sec           = 10
  health_checks         = [var.health_check_self_link]

  backend {
    group = data.google_compute_region_instance_group.was_group.self_link
  }
}

### Internal Forwarding Rule
resource "google_compute_forwarding_rule" "was_forwarding_rule" {
  name                  = var.nlb_forwarding_rule_name
  region                = var.region
  ip_protocol           = "TCP"
  ports                 = ["8080"]
  load_balancing_scheme = "INTERNAL"
  backend_service       = google_compute_region_backend_service.was_backend.self_link
  network               = var.vpc_self_link
  subnetwork            = var.subnet_self_link
}

