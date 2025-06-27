module "vpc" {
  source      = "../modules/vpc"
  vpc_name    = var.vpc_name
  subnet_name = var.subnet_name
  subnet_cidr = var.subnet_cidr
  region      = var.region
  router_name = var.router_name
  nat_name    = var.nat_name
}

module "sql" {
  source        = "../modules/sql"
  instance_name = var.db_instance_name
  region        = var.region
  vpc_self_link = module.vpc.vpc_self_link
  psa_ip_name   = var.psa_ip_name
  db_user       = var.db_user
  db_password   = var.db_password
  db_name       = var.db_name
}

module "was_template" {
  source          = "../modules/was-temp"
  template_name   = var.was_template_name
  machine_type    = var.was_machine_type
  image           = var.was_image
  region          = var.region
  subnet          = module.vpc.subnet_self_link
  db_private_ip   = module.sql.private_ip_address
  db_name         = var.db_name
  db_user         = var.db_user
  db_password     = var.db_password
  service_account = var.was_service_account
}

module "was_mig" {
  source             = "../modules/was-mig"
  region             = var.region
  mig_name           = var.was_mig_name
  template_self_link = module.was_template.template_self_link
  mig_size           = var.was_mig_size
  health_check_name  = var.was_health_check_name
}

module "nlb" {
  source                   = "../modules/nlb"
  region                   = var.region
  was_mig_name             = var.was_mig_name
  backend_service_name     = var.backend_service_name
  nlb_forwarding_rule_name = var.nlb_forwarding_rule_name
  health_check_self_link   = module.was_mig.health_check_self_link
  vpc_self_link            = module.vpc.vpc_self_link
  subnet_self_link         = module.vpc.subnet_self_link
  depends_on               = [module.was_mig]
}

module "web_template" {
  source        = "../modules/web-temp"
  web_sa_name   = var.web_sa_name
  template_name = var.web_template_name
  machine_type  = var.web_machine_type
  image         = var.web_image
  region        = var.region
  subnet        = module.vpc.subnet_self_link
  nlb_ip        = module.nlb.nlb_ip
}

module "web_mig" {
  source             = "../modules/web-mig"
  mig_name           = var.web_mig_name
  region             = var.region
  template_self_link = module.web_template.template_self_link
  mig_size           = var.web_mig_size
  zones              = var.zones
}

module "alb" {
  source                   = "../modules/alb"
  global_ip_name           = var.global_ip_name
  health_check_name        = var.web_health_check_name
  backend_service_name     = var.alb_backend_service_name
  web_mig_self_link        = module.web_mig.mig_self_link
  url_map_name             = var.url_map_name
  ssl_cert_name            = var.ssl_cert_name
  domain_name              = var.domain_name
  https_proxy_name         = var.https_proxy_name
  alb_forwarding_rule_name = var.alb_forwarding_rule_name
}

module "dns" {
  source         = "../modules/dns"
  dns_zone_name  = var.dns_zone_name
  domain_name    = var.domain_name
  alb_ip_address = module.alb.global_ip_address
  alb_dependency = module.alb
}

