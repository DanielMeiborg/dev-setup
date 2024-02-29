#!/bin/bash

# Build the Docker image
docker build -t manjaro-shell-config -f manjaro.Dockerfile .

# Run the container interactively
docker run -it manjaro-shell-config
