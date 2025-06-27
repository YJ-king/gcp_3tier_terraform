### ALB Variables

variable "global_ip_name" {
  type        = string
  description = "Name of the external IP resource"
}

variable "health_check_name" {
  type        = string
  description = "Name of the health check"
}

variable "backend_service_name" {
  type        = string
  description = "Name of the backend service"
}

variable "web_mig_self_link" {
  type        = string
  description = "Self link of the Web MIG instance group"
}

variable "url_map_name" {
  type        = string
  description = "Name of the URL map"
}

variable "ssl_cert_name" {
  type        = string
  description = "Name of the managed SSL certificate"
}

variable "domain_name" {
  type        = string
  description = "Domain to use for HTTPS certificate"
}

variable "https_proxy_name" {
  type        = string
  description = "Name of the target HTTPS proxy"
}

variable "alb_forwarding_rule_name" {
  type        = string
  description = "Name of the forwarding rule"
}

