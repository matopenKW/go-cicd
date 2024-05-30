resource "google_cloud_run_v2_service" "app" {
  name     = "cloudrun-app"
  location = var.region
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    scaling {
      max_instance_count = 1
    }

    volumes {
      name = "cloudsql"
      cloud_sql_instance {
        instances = [google_sql_database_instance.go_cicd_db.connection_name]
      }
    }

    containers {
      image   = "us-central1-docker.pkg.dev/${google_project.go_cicd.project_id}/${google_artifact_registry_repository.go_cicd.repository_id}/go-cicd-dev:latest"
      command = ["/bin/http"]
      ports {
        container_port = 8080
      }
      env {
        name  = "ENV"
        value = "dev"
      }
      env {
        name  = "DB_HOST"
        value = google_sql_database_instance.go_cicd_db.connection_name
      }
      env {
        name  = "DB_PASSWORD"
        value = "password"
      }
      env {
        name  = "DB_NAME"
        value = "user"
      }
    }
  }

  traffic {
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }
}


resource "google_cloud_run_v2_job" "default" {
  name     = "cloudrun-job"
  location = "us-central1"

  template {
    template {
      containers {
        image   = "us-central1-docker.pkg.dev/${google_project.go_cicd.project_id}/${google_artifact_registry_repository.go_cicd.repository_id}/go-cicd-dev:latest"
        command = ["/bin/cli"]
        args    = ["aa", "bb"]
      }
    }
  }
}
