resource "google_storage_bucket" "matthew_pc" {
  name = "${google_project.default.number}-backups-matthew-pc"
  location = local.region
  storage_class = "STANDARD"
}

resource "google_service_account" "matthew_pc_backup_manager" {
  account_id = "matthew-pc-backup-manager"
  display_name = "Matthew-PC Backup Manager"
}

resource "google_project_iam_custom_role" "storage_bucket_lister" {
  role_id = "storage_bucket_lister"
  title = "Storage Bucket Lister"
  permissions = [
    "storage.buckets.list"
  ]
}

resource "google_project_iam_member" "storage_bucket_lister" {
  role = google_project_iam_custom_role.storage_bucket_lister.id
  member = "serviceAccount:${google_service_account.matthew_pc_backup_manager.email}"
}

resource "google_storage_bucket_iam_member" "matthew_pc_backup_manager_access" {
  bucket = google_storage_bucket.matthew_pc.name
  role = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.matthew_pc_backup_manager.email}"
}