resource "google_storage_bucket" "backups_bucket" {
  name = "${data.google_project.project.number}-backups"
  location = local.region
  storage_class = "STANDARD"
}

resource "google_service_account" "backup_manager_sa" {
  account_id = "backup-manager"
  display_name = "Backup Manager"
}

resource "google_storage_bucket_iam_member" "backup_manager_sa_access" {
  bucket = google_storage_bucket.backups_bucket.name
  role = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.backup_manager_sa.email}"
}