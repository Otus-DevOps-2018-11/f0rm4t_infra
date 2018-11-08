#!/bin/bash

git clone -b monolith https://github.com/express42/reddit.git 
cd reddit && bundle install

sudo mv /home/appuser/reddit.service /etc/systemd/system/reddit.service
sudo systemctl enable reddit
