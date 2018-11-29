variable "project" {
  description = "Project ID"
}

variable "region" {
  description = "Region"
  default     = "europe-west1"
}

variable "zone" {
  description = "Zone"
  default     = "europe-west1-b"
}

variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}

variable "private_key_path" {
  description = "Path to the private key"
}

variable "app_disk_image" {
  description = "Disk image for reddit-app"
  default     = "reddit-app-base"
}

variable "db_disk_image" {
  description = "Disk image for DB"
  default     = "reddit-db-base"
}

variable "source_addr" {
  description = "Allowed IP addresses"
}
