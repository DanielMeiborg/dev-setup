#!/bin/bash

# Build the Docker image
docker build -t ubuntu-shell-config -f ubuntu.Dockerfile .

# Run the container interactively
docker run -it ubuntu-shell-config
