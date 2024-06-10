#!/bin/bash

# Update package lists
sudo apt-get update

# Upgrade existing packages
sudo apt-get upgrade -y

# Install Java Runtime Environment
sudo apt install -y fontconfig openjdk-17-jre

# Download the Jenkins GPG key
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

# Add the Jenkins repository to APT sources
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package lists again
sudo apt-get update

# Install Jenkins
sudo apt-get install -y jenkins

# Start the Jenkins service
sudo systemctl start jenkins

# Enable the Jenkins service to start at boot
sudo systemctl enable jenkins

