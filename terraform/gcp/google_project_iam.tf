resource "google_project_iam_binding" "github_actions_binding" {
  project = google_project.go_cicd.project_id
  role    = "roles/editor"

  members = [
    "serviceAccount:${google_service_account.github_actions.email}"
  ]
}

