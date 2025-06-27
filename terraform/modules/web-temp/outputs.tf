output "template_self_link" {
  value       = google_compute_instance_template.web_template.self_link
  description = "Self link of the Web instance template"
}

output "web_sa_email" {
  value       = google_service_account.web_sa.email
  description = "Email of the created Web service account"
}


