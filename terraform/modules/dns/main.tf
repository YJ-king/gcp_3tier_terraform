### Cloud DNS Managed Zone 참조 ###
data "google_dns_managed_zone" "yjking_zone" {
  name = var.dns_zone_name
}

### A 레코드 생성 ###
resource "google_dns_record_set" "a_record" {
  name         = var.domain_name
  type         = "A"
  ttl          = 300
  managed_zone = data.google_dns_managed_zone.yjking_zone.name
  rrdatas      = [var.alb_ip_address]

  depends_on = [var.alb_dependency]
}

