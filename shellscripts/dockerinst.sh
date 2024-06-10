#!/bin/bash

# Update package lists
sudo apt-get update

# Install prerequisites
sudo apt-get install -y ca-certificates curl gnupg

# Create directory for the Docker GPG key
sudo install -m 0755 -d /etc/apt/keyrings

# Download the Docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Ensure the Docker GPG key has the correct permissions
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the Docker repository to APT sources (use focal for Ubuntu 20.04 or jammy for Ubuntu 22.04)
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package lists again
sudo apt-get update

# Install Docker packages
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Allow non-root users to run Docker commands
sudo chmod 666 /var/run/docker.sock

