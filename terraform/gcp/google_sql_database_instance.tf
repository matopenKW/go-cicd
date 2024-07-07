resource "google_sql_database_instance" "go_cicd_db_instance" {
  name             = "cloud-run-db-instance"
  region           = var.region
  database_version = "MYSQL_8_0"
  settings {
    # FIXME: Make it variable depending on the environment
    tier = "db-f1-micro"
  }

  deletion_protection = "true"
}

resource "google_sql_database" "go_cicd_db" {
  name      = "cloud-run-db"
  instance  = google_sql_database_instance.go_cicd_db_instance.name
  charset   = "utf8mb4"
  collation = "utf8mb4_general_ci"
  project   = google_project.go_cicd.project_id
}
