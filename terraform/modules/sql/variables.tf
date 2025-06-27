### Cloud SQL Module Variables

variable "instance_name" {
  type        = string
  description = "Name of the Cloud SQL instance"
}

variable "region" {
  type        = string
  description = "Region to deploy the SQL instance"
}

variable "vpc_self_link" {
  type        = string
  description = "Self link of the VPC to peer with"
}

variable "psa_ip_name" {
  type        = string
  description = "Name of the global address for PSA"
}

variable "service_networking_domain" {
  type        = string
  description = "Service Networking domain"
  default     = "servicenetworking.googleapis.com"
}

variable "tier" {
  type        = string
  description = "SQL instance machine tier"
  default     = "db-custom-1-3840"
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
  description = "Name of the database to create"
}

