### Web 서비스 계정
resource "google_service_account" "web_sa" {
  account_id   = var.web_sa_name
  display_name = "Web Instance Service Account"
}

### Web 인스턴스 템플릿
resource "google_compute_instance_template" "web_template" {
  name         = var.template_name
  machine_type = var.machine_type
  region       = var.region
  tags         = ["web", "internal", "iap-ssh", "lb-healthcheck"]

  disk {
    source_image = var.image
    auto_delete  = true
    boot         = true
  }

  network_interface {
    subnetwork = var.subnet
    access_config {}
  }

  metadata_startup_script = templatefile("${path.module}/startup.sh.tpl", {
    NLB_IP = var.nlb_ip
  })

  service_account {
    email  = google_service_account.web_sa.email
    scopes = ["cloud-platform"]
  }
}

