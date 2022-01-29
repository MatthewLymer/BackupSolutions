resource "google_service_account" "qnap_backup_manager" {
  account_id   = "qnap-backup-manager"
  display_name = "QNAP Backup Manager"
}

resource "google_project_iam_custom_role" "qnap_backup_manager" {
  project = local.project.id
  role_id = "qnap_backup_manager"
  title   = "QNAP Backup Manager"
  permissions = [
    "resourcemanager.projects.get",
    "storage.buckets.get",
    "storage.buckets.list",
    "storage.buckets.update"
  ]
}

resource "google_project_iam_member" "qnap_backup_manager" {
  project = local.project.id
  role    = google_project_iam_custom_role.qnap_backup_manager.id
  member  = "serviceAccount:${google_service_account.qnap_backup_manager.email}"
}
