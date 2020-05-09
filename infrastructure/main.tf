locals {
  region = "northamerica-northeast1"
  billing_account = "017629-BB9381-1C2281"
  
  project = {
	id = "matthew-pc-backup"
	name = "Matthew's PC Backup"
  }
}

provider "google" {
  region  = local.region
  project = local.project.id
}

resource "google_project" "default" {
  project_id = local.project.id
  name = local.project.name
  billing_account = local.billing_account
}

data "google_project" "project" {
}

resource "google_storage_bucket" "tfstate_bucket" {
  name = "tfstate-${data.google_project.project.number}"
  location = local.region
  storage_class = "STANDARD"
}

terraform {
  # NOTE:
  #   When first running this project, the tfstate_bucket won't exist
  #   so comment out the backend lines, do a terraform init & apply
  #   then uncomment out the backend lines, do another terraform init & apply
  #   to start using the backend

  backend "gcs" {
    bucket = "tfstate-127296570571"
  }
}