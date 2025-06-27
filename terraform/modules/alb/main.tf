### 외부 IP
resource "google_compute_global_address" "web_ip" {
  name = var.global_ip_name
}

### 웹 헬스체크
resource "google_compute_health_check" "web_health_check" {
  name               = var.health_check_name
  check_interval_sec = 5
  timeout_sec        = 5
  healthy_threshold  = 2
  unhealthy_threshold = 2

  http_health_check {
    port = 80
  }
}

### 백엔드 서비스
resource "google_compute_backend_service" "web_backend" {
  name                  = var.backend_service_name
  load_balancing_scheme = "EXTERNAL"
  port_name             = "http"
  protocol              = "HTTP"
  timeout_sec           = 10
  health_checks         = [google_compute_health_check.web_health_check.self_link]

  backend {
    group = var.web_mig_self_link
  }
}

### URL 맵
resource "google_compute_url_map" "web_url_map" {
  name            = var.url_map_name
  default_service = google_compute_backend_service.web_backend.self_link
}

### SSL 인증서 (도메인 필요)
resource "google_compute_managed_ssl_certificate" "web_ssl_cert" {
  name = var.ssl_cert_name

  managed {
    domains = [var.domain_name]
  }
}

### HTTPS Proxy
resource "google_compute_target_https_proxy" "web_https_proxy" {
  name             = var.https_proxy_name
  url_map          = google_compute_url_map.web_url_map.self_link
  ssl_certificates = [google_compute_managed_ssl_certificate.web_ssl_cert.self_link]
}

### 포워딩 룰
resource "google_compute_global_forwarding_rule" "web_forwarding_rule" {
  name       = var.alb_forwarding_rule_name
  target     = google_compute_target_https_proxy.web_https_proxy.self_link
  port_range = "443"
  ip_address = google_compute_global_address.web_ip.address
}

