#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
apt-get upgrade -y
apt-get install nginx -y
systemctl enable nginx
systemctl start nginx