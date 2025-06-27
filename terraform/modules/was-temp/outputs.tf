output "template_self_link" {
  value       = google_compute_instance_template.was_template.self_link
  description = "Self link of the WAS instance template"
}

