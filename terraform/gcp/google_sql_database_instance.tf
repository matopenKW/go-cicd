resource "google_sql_database_instance" "go_cicd_db" {
  name             = "cloud-run-instance"
  region           = var.region
  database_version = "MYSQL_8_0"
  settings {
    # FIXME: Make it variable depending on the environment
    tier = "db-f1-micro"
  }

  deletion_protection = "true"
}
