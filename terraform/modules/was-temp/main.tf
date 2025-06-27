### WAS Instance Template
resource "google_compute_instance_template" "was_template" {
  name         = var.template_name
  machine_type = var.machine_type
  region       = var.region

  tags = ["was", "internal", "lb-healthcheck"]

  disk {
    source_image = var.image
    auto_delete  = true
    boot         = true
  }

  network_interface {
    subnetwork = var.subnet
    access_config {}
  }

metadata_startup_script = <<-EOT
#!/bin/bash

### 1. 환경변수 설정
echo "DB_HOST=${var.db_private_ip}" >> /etc/environment
echo "DB_NAME=${var.db_name}" >> /etc/environment
echo "DB_USER=${var.db_user}" >> /etc/environment
echo "DB_PASSWORD=${var.db_password}" >> /etc/environment
source /etc/environment

### 2. Tomcat 내부 application.properties 치환
cat <<EOF > /opt/tomcat/webapps/ROOT/WEB-INF/classes/application.properties
spring.datasource.url=jdbc:mysql://${var.db_private_ip}:3306/${var.db_name}?autoReconnect=true&failOverReadOnly=false&connectTimeout=2000&socketTimeout=3000&maxReconnects=3
spring.datasource.username=${var.db_user}
spring.datasource.password=${var.db_password}
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver

spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
server.port=8080
spring.datasource.hikari.connection-init-sql=SET NAMES utf8mb4
spring.datasource.hikari.connection-test-query=SELECT 1
EOF

chown tomcat:tomcat /opt/tomcat/webapps/ROOT/WEB-INF/classes/application.properties


### 3. 프로젝트 원본 경로 application.properties 치환
sed -i "s|\$DB_HOST|${var.db_private_ip}|g" /home/cohon/petclinic_btc/src/main/resources/application.properties

### 4. pom.xml 내 DB 주소 치환 (있다면)
sed -i "s|\$DB_HOST|${var.db_private_ip}|g" /home/cohon/petclinic_btc/pom.xml

### 5. tomcat 잔존파일 치환
sed -i "s|\$DB_HOST|${var.db_private_ip}|g" /opt/tomcat/WEB-INF/classes/application.properties

### 6. data-access.properties
sed -i "s|\$DB_HOST|${var.db_private_ip}|g" /opt/tomcat/webapps/ROOT/WEB-INF/classes/spring/data-access.properties

### 7. datasource-config.xml
sed -i "s|\$DB_HOST|${var.db_private_ip}|g" /opt/tomcat/webapps/ROOT/WEB-INF/classes/spring/datasource-config.xml

### 8. pom.xml2
sed -i "s|\$DB_HOST|${var.db_private_ip}|g" /opt/tomcat/webapps/ROOT/META-INF/maven/org.springframework.samples/spring-framework-petclinic/pom.xml

### 9. Tomcat 재시작
systemctl restart tomcat
EOT


  service_account {
    email  = google_service_account.was_sa.email
    scopes = ["cloud-platform"]
  }
}

### WAS Service Account
resource "google_service_account" "was_sa" {
  account_id   = "was-sa"
  display_name = "WAS Service Account"
}

