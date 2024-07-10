#!/bin/bash

# Detect the shell
if [ -n "$ZSH_VERSION" ]; then
    SHELL_NAME="zsh"
elif [ -n "$BASH_VERSION" ]; then
    SHELL_NAME="bash"
else
    echo "Unsupported shell. Please use Bash or Zsh."
    exit 1
fi

# Make the script executable
chmod +x "$0"

# Check Node.js version
node_version=$(node -v | cut -d 'v' -f 2)
if [[ $(echo "$node_version 18.0.0" | tr ' ' '\n' | sort -V | head -n 1) != "18.0.0" ]]; then
    echo "Error: Node.js version 18 or newer is required."
    exit 1
fi

# Check if npx promptfoo@latest can be run
if ! npx promptfoo@latest --version &>/dev/null; then
    echo "Error: Unable to run 'npx promptfoo@latest'. Please make sure it's installed correctly."
    exit 1
fi

# Create function for running npx promptfoo@latest eval
function prompt() {
    npx promptfoo@latest "$@"
}

# Check if the function works
if [ "$SHELL_NAME" = "zsh" ]; then
    if ! functions prompt &>/dev/null; then
        echo "Error: Unable to create 'prompt' function. Please check your shell configuration."
        exit 1
    fi
elif [ "$SHELL_NAME" = "bash" ]; then
    if ! declare -f prompt &>/dev/null; then
        echo "Error: Unable to create 'prompt' function. Please check your shell configuration."
        exit 1
    fi
fi

# Prompt user for password
if [ "$SHELL_NAME" = "zsh" ]; then
    read -s "password?Enter the password for your interview: "
else
    read -s -p "Enter the password for your interview: " password
fi
echo

# Make HTTP request to server and parse JSON for openrouterKey and error message
# Define base URL
base_url="https://prompting-interview.onrender.com"

# Verify password and get OpenRouter key
response=$(curl -s -X POST -H "Content-Type: application/json" -d "{\"candidate_password\":\"$password\"}" "$base_url/verify-password")
status_code=$(echo "$response" | jq -r '.status // empty')
openrouter_key=$(echo "$response" | jq -r '.openrouterKey')
error_message=$(echo "$response" | jq -r '.error')

if [ -z "$openrouter_key" ] || [ "$openrouter_key" == "null" ]; then
    if [ -n "$error_message" ] && [ "$error_message" != "null" ]; then
        echo "Error (Status $status_code): $error_message"
    else
        echo "Error (Status $status_code): Unable to retrieve Openrouter key. Please check your password and try again."
    fi
    exit 1
fi

# Download and unarchive hidden files
echo "Downloading interview files..."
curl -s -X POST -H "Content-Type: application/json" -d "{\"candidate_password\":\"$password\"}" "$base_url/download-hidden-files-prompting" -o interview_files.zip

if [ $? -eq 0 ]; then
    echo "Unarchiving interview files..."
    unzip_output=$(unzip -q interview_files.zip -d interview_files 2>&1)
    if [ $? -eq 0 ]; then
        rm interview_files.zip
        echo "Interview files downloaded and unarchived successfully."
    else
        echo "Error: Failed to unarchive interview files."
        echo "Unzip output: $unzip_output"
        exit 1
    fi
else
    echo "Error: Failed to download interview files."
    exit 1
fi

# Set OPENROUTER_API_KEY environment variable
export OPENROUTER_API_KEY="$openrouter_key"
export OPENAI_API_KEY="$openrouter_key"

echo "Environment check complete"


# The setting of commands by this script doesn't work on my computer :(
echo "
Run the commands in your terminal to start the interview:
"
echo "alias prompt='npx promptfoo@latest'"
echo "export OPENROUTER_API_KEY=$OPENROUTER_API_KEY"
echo "export OPENAI_API_KEY=$OPENAI_API_KEY"