output "mig_self_link" {
  value       = google_compute_region_instance_group_manager.web_mig.instance_group
  description = "Instance group of the Web MIG"
}

