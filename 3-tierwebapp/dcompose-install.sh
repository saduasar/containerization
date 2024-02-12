#!/bin/bash

#Update the package index, and install the latest version of Docker Compose
sudo apt-get update -y
sudo apt  install docker-compose

# Verify that Docker Compose is installed correctly by checking the version.
docker compose version
