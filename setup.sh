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


# Ask the user for their API key
echo "Please enter your OpenAI API key:"
read OPENAI_API_KEY

# Create or overwrite the .env file
echo "OPENAI_API_KEY=$OPENAI_API_KEY" > .env

# Notify the user that the file was created
echo "The .env file has been created with your API key."


while true; do
  # Ask the user for input
  echo "Use official repo docker-compose.yml (takes longer time) ? [Y/n]"

  # Read the user's answer
  read answer
  
  # If the answer is empty, set it to "yes"
  if [[ -z $answer ]]; then
    answer="y"
  fi

  # Process the answer
  case $answer in
    [yY] | [yY][eE][sS] )
      echo "You chose to use the official repo docker-compose.yml"
      git init
      git remote add origin https://github.com/Significant-Gravitas/Auto-GPT.git
      git fetch origin
      git checkout -b stable --track origin/stable
      
      echo "build AutoGPT docker"
      sudo docker-compose build auto-gpt
      break # Exit the loop
      ;;
      
    [nN] | [nN][oO] )
      echo "Using defualt docker-compose.yml instead"
      cp ../default-docker-compose.yml ./docker-compose.yml
      
      echo "pull docker..."
      sudo docker pull significantgravitas/auto-gpt

      break # Exit the loop
      ;;

    # If the user enters anything else, ask them again
    * )
      echo "Invalid input. Please answer with yes or no (y/n)."
      ;;
  esac
done


echo "starting AutoGPT..."
sudo docker-compose run --rm auto-gpt

