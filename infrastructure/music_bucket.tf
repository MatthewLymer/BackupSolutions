resource "google_storage_bucket" "music" {
  name          = "${google_project.default.number}-backups-music"
  location      = "us-central1"
  storage_class = "COLDLINE"
}
