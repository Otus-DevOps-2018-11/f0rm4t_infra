#!/bin/bash

gcloud compute instances create reddit-app \
  --machine-type=f1-micro \
  --image-family=reddit-full \
  --tags puma-server \
  --restart-on-failure
