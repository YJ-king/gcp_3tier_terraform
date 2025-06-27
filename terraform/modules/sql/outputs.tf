output "private_ip_address" {
  value       = google_sql_database_instance.primary.private_ip_address
  description = "Private IP address of Cloud SQL"
}

output "instance_connection_name" {
  value       = google_sql_database_instance.primary.connection_name
  description = "Cloud SQL connection name"
}

