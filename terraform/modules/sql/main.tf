### PSA IP Reservation
resource "google_compute_global_address" "private_ip_alloc" {
  name          = var.psa_ip_name
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.vpc_self_link
}

### Service Networking Peering
resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = var.vpc_self_link
  service                 = "services/${var.service_networking_domain}"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]

  depends_on = [
    google_compute_global_address.private_ip_alloc
  ]
}

### Cloud SQL (HA)
resource "google_sql_database_instance" "primary" {
  name             = var.instance_name
  region           = var.region
  database_version = "MYSQL_8_0"

  settings {
    tier              = var.tier
    availability_type = "REGIONAL"

    backup_configuration {
      enabled            = true
      binary_log_enabled = true
    }

    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc_self_link
    }

    database_flags {
      name  = "log_bin_trust_function_creators"
      value = "on"
    }
  }

  deletion_protection = false
  depends_on          = [google_service_networking_connection.private_vpc_connection]
}

### SQL User
resource "google_sql_user" "user" {
  name     = var.db_user
  instance = google_sql_database_instance.primary.name
  password = var.db_password
}

### SQL Database
resource "google_sql_database" "db" {
  name     = var.db_name
  instance = google_sql_database_instance.primary.name
}

