#!/bin/bash

# Step 1: Install prerequisite packages
sudo apt-get update
sudo apt-get install -y wget apt-transport-https gnupg lsb-release

# Step 2: Add Trivy repository key
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -

# Step 3: Add Trivy repository to sources
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list

# Step 4: Update package index
sudo apt-get update

# Step 5: Install Trivy
sudo apt-get install -y trivy

