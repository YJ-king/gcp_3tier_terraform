output "global_ip_address" {
  value       = google_compute_global_address.web_ip.address
  description = "External IP address for the HTTPS Load Balancer"
}

