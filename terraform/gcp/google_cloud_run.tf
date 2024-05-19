resource "google_cloud_run_v2_job" "default" {
  name     = "cloudrun-job"
  location = "us-central1"

  template {
    template {
      containers {
        image = "us-central1-docker.pkg.dev/${google_project.go_cicd.project_id}/${google_artifact_registry_repository.go_cicd.repository_id}/go-cicd-dev:latest"
        command = ["/bin/cli"]
        args    = ["aa", "bb"]
      }
    }
  }
}
