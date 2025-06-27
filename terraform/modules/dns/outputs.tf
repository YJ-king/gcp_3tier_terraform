output "dns_record_fqdn" {
  description = "FQDN that was registered"
  value       = google_dns_record_set.a_record.name
}

