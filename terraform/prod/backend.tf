terraform {
  backend "gcs" {
    bucket = "storage-bucket-reddit-app-prod"
  }
}
