resource "google_storage_bucket" "default" {
  name          = "${google_project.default.number}-backups-default"
  location      = "northamerica-northeast1"
  storage_class = "NEARLINE"
}

resource "google_service_account" "default_backup_manager" {
  account_id   = "default-backup-manager"
  display_name = "Default Backup Manager"
}

resource "google_project_iam_custom_role" "storage_bucket_lister" {
  project = local.project.id
  role_id = "storage_bucket_lister"
  title   = "Storage Bucket Lister"
  permissions = [
    "storage.buckets.list"
  ]
}

resource "google_project_iam_member" "storage_bucket_lister" {
  project = local.project.id
  role    = google_project_iam_custom_role.storage_bucket_lister.id
  member  = "serviceAccount:${google_service_account.default_backup_manager.email}"
}

resource "google_storage_bucket_iam_member" "default_backup_manager_access" {
  bucket = google_storage_bucket.default.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.default_backup_manager.email}"
}