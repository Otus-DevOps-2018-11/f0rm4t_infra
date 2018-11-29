terraform {
  backend "gcs" {
    bucket = "storage-bucket-reddit-app-stage"
  }
}
