#!/bin/bash

# Update and upgrade the system
sudo apt update && sudo apt upgrade -y

# Install necessary tools
sudo apt install -y curl git unzip 

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Add the user to the docker group (automatically fetches current username)
sudo usermod -aG docker $USER

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Log out and log back in so that your group membership is re-evaluated
newgrp docker 

# Clone the Auto-GPT repository
git clone -b stable https://github.com/Significant-Gravitas/Auto-GPT.git
cd Auto-GPT

# Prompt the user for the OpenAI API key
echo -n "Enter your OpenAI API key: "
read -r OPENAI_API_KEY

# Replace the placeholder with the user's OpenAI API key in the .env file
cp .env.template .env
sed -i "s/OPENAI_API_KEY=/OPENAI_API_KEY=$OPENAI_API_KEY/" .env

# Pull the latest Docker image
docker pull significantgravitas/auto-gpt

# Build and run Auto-GPT
docker-compose build auto-gpt
docker-compose run --rm auto-gpt
