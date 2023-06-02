#!/bin/bash

# This script sets up and runs Auto-GPT in a Docker container.

# Start with some debugging information
echo "Starting Auto-GPT setup script..."

# Check if the user is in the docker group
if ! id -nG "$USER" | grep -qw docker; then
    echo "Adding user to the docker group..."
    sudo usermod -aG docker $USER
fi

# Re-evaluating group membership
echo "Re-evaluating group membership..."
sudo su - $USER

# Cloning the Auto-GPT repository
echo "Cloning the Auto-GPT repository..."
git clone -b stable https://github.com/Significant-Gravitas/Auto-GPT.git
cd Auto-GPT

# Ask the user for their OpenAI API key
echo "Enter your OpenAI API key: "
read OPENAI_API_KEY

# Replacing the placeholder with the user's OpenAI API key in the .env file
echo "Replacing the placeholder with your OpenAI API key in the .env file..."
sed -i "s/your-openai-key/${OPENAI_API_KEY}/g" .env

# Pulling the latest Docker image
echo "Pulling the latest Docker image..."
docker pull significantgravitas/auto-gpt

# Running the Docker image
echo "Running the Docker image..."
docker-compose run --rm auto-gpt
