output "nlb_ip" {
  value       = google_compute_forwarding_rule.was_forwarding_rule.ip_address
  description = "Internal IP address of the NLB"
}

