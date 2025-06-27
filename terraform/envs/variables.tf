### GCP Provider Settings
variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type        = string
  description = "Default region for resources"
}

variable "zone" {
  type        = string
  description = "Default zone for resources"
}

### VPC Module Variables

variable "vpc_name" {
  type        = string
  description = "Name of the VPC network"
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet"
}

variable "subnet_cidr" {
  type        = string
  description = "CIDR range for the subnet"
}

variable "router_name" {
  type        = string
  description = "Cloud Router name"
}

variable "nat_name" {
  type        = string
  description = "Cloud NAT name"
}

variable "db_instance_name" {
  type        = string
  description = "Cloud SQL instance name"
}

variable "psa_ip_name" {
  type        = string
  description = "Name of the global address for PSA"
}

variable "db_user" {
  type        = string
  description = "SQL username"
}

variable "db_password" {
  type        = string
  description = "SQL user password"
}

variable "db_name" {
  type        = string
  description = "Database name"
}

variable "was_template_name" {
  type        = string
  description = "Name of the WAS instance template"
}

variable "was_machine_type" {
  type        = string
  description = "Machine type for the WAS template"
}

variable "was_image" {
  type        = string
  description = "Custom image for WAS instance"
}

variable "was_service_account" {
  type        = string
  description = "Service account email for WAS"
}

variable "was_mig_name" {
  type        = string
  description = "Name of the WAS MIG"
}

variable "was_mig_size" {
  type        = number
  description = "Number of instances in the WAS MIG"
}

variable "was_health_check_name" {
  type        = string
  description = "Health check name for the WAS MIG"
}

variable "backend_service_name" {
  type        = string
  description = "Backend service name for NLB"
}

variable "nlb_forwarding_rule_name" {
  type        = string
  description = "Forwarding rule name for NLB"
}

variable "alb_forwarding_rule_name" {
  type        = string
  description = "Forwarding rule name for ALB"
}

variable "web_sa_name" {
  type        = string
  description = "Web service account ID"
}

variable "web_template_name" {
  type        = string
  description = "Web instance template name"
}

variable "web_machine_type" {
  type        = string
  description = "Machine type for Web"
}

variable "web_image" {
  type        = string
  description = "Custom Web image"
}

variable "web_mig_name" {
  type        = string
  description = "Name of the Web MIG"
}

variable "web_mig_size" {
  type        = number
  description = "Number of Web instances"
}

variable "zones" {
  type        = list(string)
  description = "Zones for regional Web MIG"
}

variable "global_ip_name" {
  type        = string
  description = "Global IP name for HTTPS Load Balancer"
}

variable "web_health_check_name" {
  type        = string
  description = "Name of the Web health check"
}

variable "alb_backend_service_name" {
  type        = string
  description = "Backend service name for ALB"
}

variable "url_map_name" {
  type        = string
  description = "Name of the URL map"
}

variable "ssl_cert_name" {
  type        = string
  description = "Name of the SSL certificate"
}

variable "domain_name" {
  type        = string
  description = "Domain name used for SSL"
}

variable "https_proxy_name" {
  type        = string
  description = "HTTPS proxy name"
}

variable "dns_zone_name" {
  description = "DNS zone name (e.g., example.com.)"
  type        = string
}

