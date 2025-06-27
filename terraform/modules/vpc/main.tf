### VPC Network
resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

### Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc.id
}

### Firewall: Internal communication
resource "google_compute_firewall" "allow_internal" {
  name    = "allow-internal"
  network = google_compute_network.vpc.name

  direction = "INGRESS"
  priority  = 1000

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  source_ranges = [var.subnet_cidr]
  target_tags   = ["web", "was"]
}

### Firewall: Web WAS access
resource "google_compute_firewall" "allow_web_to_was" {
  name    = "allow-web-to-was"
  network = google_compute_network.vpc.name

  direction   = "INGRESS"
  source_tags = ["web"]
  target_tags = ["was"]

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  description = "Allow internal web-to-was traffic on port 8080"
}

### Firewall: IAP SSH access
resource "google_compute_firewall" "allow_iap_ssh" {
  name    = "allow-iap-ssh"
  network = google_compute_network.vpc.name

  direction = "INGRESS"
  priority  = 1000

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["35.235.240.0/20"]
  target_tags   = ["web", "was"]
}

### Firewall: Load Balancer Health Check
resource "google_compute_firewall" "allow_lb_healthcheck" {
  name    = "allow-lb-healthcheck"
  network = google_compute_network.vpc.name

  direction = "INGRESS"
  priority  = 1000

  allow {
    protocol = "tcp"
    ports    = ["80", "8080"]
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags   = ["web", "was"]
}

### Cloud Router
resource "google_compute_router" "nat_router" {
  name    = var.router_name
  region  = var.region
  network = google_compute_network.vpc.name
}

### Cloud NAT
resource "google_compute_router_nat" "nat_config" {
  name                               = var.nat_name
  router                             = google_compute_router.nat_router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

