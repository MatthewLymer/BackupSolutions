resource "google_storage_bucket" "default" {
  name          = "${google_project.default.number}-backups-default"
  location      = "northamerica-northeast1"
  storage_class = "NEARLINE"
}
