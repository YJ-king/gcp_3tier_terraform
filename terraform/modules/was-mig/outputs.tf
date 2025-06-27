output "mig_self_link" {
  value       = google_compute_region_instance_group_manager.was_mig.instance_group
  description = "Instance group of the WAS MIG"
}

output "health_check_self_link" {
  value       = google_compute_health_check.was_hc.self_link
  description = "Health check self link for the WAS MIG"
}

