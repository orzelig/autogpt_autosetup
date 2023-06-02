#!/bin/bash

# This script sets up and runs Auto-GPT in a Docker container.

echo "Installing docker..."
sudo apt install -y docker.io
echo "Installing docker-compose..."
sudo apt install docker-compose
echo "Docker version is"
docker -v
echo "Creating folder..."
mkdir Auto-GPT
cd Auto-GPT

echo "Create docker-compose.yml..."
cat << EOF > docker-compose.yml
version: "3.9"
services:
  auto-gpt:
    image: significantgravitas/auto-gpt
    depends_on:
      - redis
    env_file:
      - .env
    environment:
      MEMORY_BACKEND: \${MEMORY_BACKEND:-redis}
      REDIS_HOST: \${REDIS_HOST:-redis}
    profiles: ["exclude-from-up"]
    volumes:
      - ./auto_gpt_workspace:/app/autogpt/auto_gpt_workspace
      - ./data:/app/data
      - ./logs:/app/logs
  redis:
    image: "redis/redis-stack-server:latest"
EOF

# Ask the user for their API key
echo "Please enter your OpenAI API key:"
read OPENAI_API_KEY

# Create or overwrite the .env file
echo "OPENAI_API_KEY=$OPENAI_API_KEY" > .env

# Notify the user that the file was created
echo "The .env file has been created with your API key."

echo "pull docker..."
sudo docker pull significantgravitas/auto-gpt

echo "starting AutoGPT..."
sudo docker-compose run --rm auto-gpt

