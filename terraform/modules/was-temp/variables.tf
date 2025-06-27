### WAS Template Variables

variable "template_name" {
  type        = string
  description = "Name of the instance template"
}

variable "machine_type" {
  type        = string
  description = "Machine type to use for WAS"
}

variable "image" {
  type        = string
  description = "Custom image to use"
}

variable "region" {
  type        = string
  description = "Region to deploy in"
}

variable "subnet" {
  type        = string
  description = "Subnetwork self_link"
}

variable "db_private_ip" {
  type        = string
  description = "Private IP of the Cloud SQL instance"
}

variable "db_name" {
  type        = string
  description = "Name of the DB"
}

variable "db_user" {
  type        = string
  description = "DB username"
}

variable "db_password" {
  type        = string
  description = "DB password"
}

variable "service_account" {
  type        = string
  description = "Service account email for the VM"
}

