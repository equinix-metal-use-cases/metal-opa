#!/usr/bin/env bash

apt update
apt install curl git -y

# install opa
curl -L -o /usr/local/sbin/opa https://openpolicyagent.org/downloads/v0.34.2/opa_linux_amd64_static
chmod +x /usr/local/sbin/opa

# install serverspec
apt install ruby ruby-bundler -y
gem install serverspec 