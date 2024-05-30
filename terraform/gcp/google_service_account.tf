resource "google_service_account" "github_actions" {
  account_id   = "github-actions-ci"
  display_name = "GitHub Actions Service Account"
}

resource "google_service_account_iam_binding" "github_actions_workload_identity_user" {
  service_account_id = google_service_account.github_actions.name
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "principalSet://iam.googleapis.com/projects/${google_project.go_cicd.number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.github_actions_pool.workload_identity_pool_id}/attribute.repository/matopenKW/go-cicd"
  ]
}