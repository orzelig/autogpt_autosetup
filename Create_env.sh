#!/bin/bash

# Create a new .env file
touch .env

# Function to prompt for input and write to .env file
ask() {
    read -p "Enter value for $1 (Default: $2): " input
    echo "$1=${input:-$2}" >> .env
}

# Function to handle boolean type environment variables
ask_bool() {
    while true; do
        read -p "Enter value for $1 (Default: $2) [True/False]: " input
        input=${input:-$2}
        case $input in
            [Tt][Rr][Uu][Ee]|[Ff][Aa][Ll][Ss][Ee])
                echo "$1=$input" >> .env
                break
                ;;
            *)
                echo "Invalid input. Please enter True or False."
                ;;
        esac
    done
}

# Function to handle list type environment variables
ask_list() {
    read -p "Enter comma separated values for $1 (Default: $2): " input
    echo "$1=${input:-$2}" >> .env
}

# Begin AUTO-GPT - GENERAL SETTINGS
echo "AUTO-GPT - GENERAL SETTINGS" >> .env

ask_bool "EXECUTE_LOCAL_COMMANDS" "False"
ask_bool "RESTRICT_TO_WORKSPACE" "True"
ask "USER_AGENT" "\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36\""
ask "AI_SETTINGS_FILE" "ai_settings.yaml"
ask "PROMPT_SETTINGS_FILE" "prompt_settings.yaml"
ask "AUTHORISE_COMMAND_KEY" "y"
ask "EXIT_KEY" "n"
ask_bool "PLAIN_OUTPUT" "False"
ask_list "DISABLED_COMMAND_CATEGORIES" ""
ask_list "DENY_COMMANDS" ""
ask_list "ALLOW_COMMANDS" ""

# Continue with the rest of the questions...

# OpenAI Settings
echo "LLM PROVIDER" >> .env
ask "OPENAI_API_KEY" "your-openai-api-key"
ask "TEMPERATURE" "0"
ask_bool "USE_AZURE" "False"
ask "OPENAI_ORGANIZATION" "your-openai-organization-key-if-applicable"
ask "SMART_LLM_MODEL" "gpt-4"
ask "FAST_LLM_MODEL" "gpt-3.5-turbo"
ask "FAST_TOKEN_LIMIT" "4000"
ask "SMART_TOKEN_LIMIT" "8000"
ask "EMBEDDING_MODEL" "text-embedding-ada-002"

# Memory Settings
echo "MEMORY" >> .env
ask "MEMORY_BACKEND" "json_file"
ask "MEMORY_INDEX" "auto-gpt-memory"
ask "REDIS_HOST" "localhost"
ask "REDIS_PORT" "6379"
ask "REDIS_PASSWORD" ""
ask_bool "WIPE_REDIS_ON_START" "True"

# Image Generation Provider
echo "IMAGE GENERATION PROVIDER" >> .env
ask "IMAGE_PROVIDER" "dalle"
ask "IMAGE_SIZE" "256"
ask "HUGGINGFACE_IMAGE_MODEL" "CompVis/stable-diffusion-v1-4"
ask "HUGGINGFACE_API_TOKEN" "your-huggingface-api-token"
ask "SD_WEBUI_AUTH" ""
ask "SD_WEBUI_URL" "http://127.0.0.1:7860"

# Audio to Text Provider
echo "AUDIO TO TEXT PROVIDER" >> .env
ask "HUGGINGFACE_AUDIO_TO_TEXT_MODEL" "facebook/wav2vec2-base-960h"

# Git Provider
echo "GIT PROVIDER FOR REPOSITORY ACTIONS" >> .env
ask "GITHUB_API_KEY" "github_pat_123"
ask "GITHUB_USERNAME" "your-github-username"

# Web Browsing
echo "WEB BROWSING" >> .env
ask_bool "HEADLESS_BROWSER" "True"
ask "USE_WEB_BROWSER" "chrome"
ask "BROWSE_CHUNK_MAX_LENGTH" "3000"
ask "BROWSE_SPACY_LANGUAGE_MODEL" "en_core_web_sm"
ask "GOOGLE_API_KEY" "your-google-api-key"
ask "CUSTOM_SEARCH_ENGINE_ID" "your-custom-search-engine-id"

# TTS Provider
echo "TTS PROVIDER" >> .env
ask_bool "USE_MAC_OS_TTS" "False"
ask_bool "USE_BRIAN_TTS" "False"
ask "ELEVENLABS_API_KEY" "your-elevenlabs-api-key"
ask "ELEVENLABS_VOICE_1_ID" "your-voice-id-1"
ask "ELEVENLABS_VOICE_2_ID" "your-voice-id-2"

# Twitter API
echo "TWITTER API" >> .env
ask "TW_CONSUMER_KEY" ""
ask "TW_CONSUMER_SECRET" ""
ask "TW_ACCESS_TOKEN" ""
ask "TW_ACCESS_TOKEN_SECRET" ""

# Allowlisted Plugins
echo "ALLOWLISTED PLUGINS" >> .env
ask_list "ALLOWLISTED_PLUGINS" ""
ask_list "DENYLISTED_PLUGINS" ""

# Chat Plugin Settings
echo "CHAT PLUGIN SETTINGS" >> .env
ask_bool "CHAT_MESSAGES_ENABLED" "False"
