#!/bin/bash

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

# Create alias for running npx promptfoo@latest
alias prompt='npx promptfoo@latest'

echo "Environment check complete"
