resource "google_artifact_registry_repository" "go_cicd" {
  format        = "DOCKER"
  location      = "us-central1"
  project       = google_project.go_cicd.project_id
  repository_id = "go-cicd"
}
