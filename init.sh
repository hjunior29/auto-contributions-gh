#!/bin/bash

set -e
set -x

# Load .env
export $(grep -v '^#' .env | xargs)

# Build Docker image
docker build -t auto-contributions:latest .

# Run Docker Container
docker run -d \
  --env GITHUB_USER_EMAIL=$GITHUB_USER_EMAIL \
  --env GITHUB_USER_NAME=$GITHUB_USER_NAME \
  --env GITHUB_TOKEN=$GITHUB_TOKEN \
  --env GITHUB_REPO=$GITHUB_REPO \
auto-contributions:latest
