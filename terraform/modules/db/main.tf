resource "google_compute_instance" "db" {
  name         = "reddit-db-${var.env}"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["reddit-db-${var.env}"]

  boot_disk {
    initialize_params {
      image = "${var.db_disk_image}"
    }
  }

  network_interface {
    network       = "default"
    access_config = {}
  }

  metadata {
    ssh-keys = "appuser:${file("${var.public_key_path}")}"
  }

  connection {
    type        = "ssh"
    user        = "appuser"
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "file" {
    source      = "${path.module}/files/mongod.conf"
    destination = "/tmp/mongod.conf"
  }

  provisioner "remote-exec" {
    script = "${path.module}/files/configure.sh"
  }
}

resource "google_compute_firewall" "firewall_mongo" {
  name    = "allow-mongo-default-${var.env}"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["21017"]
  }

  target_tags = ["reddit-db-${var.env}"]
  source_tags = ["reddit-app-${var.env}"]
}
