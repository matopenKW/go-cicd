provider "google" {
  project = "wallon-go-cicd"
  region  = "asia-northeast1"
}

terraform {
  backend "gcs" {
    bucket = "go_cicd_tf"
    prefix = "terraform/state"
  }
}

resource "google_project" "go_cicd" {
  name            = "go-cicd"
  project_id      = "wallon-go-cicd"
  lifecycle {
    ignore_changes = [
      billing_account
    ]
  }
}


resource "google_project_service" "artifact_registry" {
  project = google_project.go_cicd.project_id
  service = "artifactregistry.googleapis.com"

  disable_on_destroy = false
}

resource "google_project_service" "iam_googleapis_com" {
  project = google_project.go_cicd.project_id
  service = "iam.googleapis.com"

  disable_on_destroy = false
}

#resource "google_project_service" "secret_manager" {
#  project = google_project.go_cicd.project_id
#  service = "secretmanager.googleapis.com"
#
#  disable_on_destroy = false
#}
#
#resource "google_project_service" "cloud_sql" {
#  project = google_project.go_cicd.project_id
#  service = "sqladmin.googleapis.com"
#
#  disable_on_destroy = false
#}
