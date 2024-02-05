#!/bin/bash

# Base directory where all repositories will be cloned
BASE_DIR="/git_repos"

# Function to display help
show_help() {
    echo "Usage: $0 <git_repository_url>"
    echo
    echo "This script clones or updates a Git repository under the $BASE_DIR directory."
    echo
    echo "Arguments:"
    echo "  git_repository_url  The URL of the Git repository to clone or update."
}

# Function to check if a command exists
command_exists() {
    type "$1" &> /dev/null
}

# Show help if not enough arguments
if [ "$#" -ne 1 ]; then
    show_help
    exit 1
fi

# Ensure git is installed
if ! command_exists git; then
    echo "Error: git is not installed."
    exit 1
fi

# Repository URL from the first argument
REPO_URL="$1"

# Extract the name of the repository from the URL
REPO_NAME=$(basename -s .git "$REPO_URL")

# Full path to the repository directory
REPO_DIR="$BASE_DIR/$REPO_NAME"

# Clone the repository if it doesn't exist, or pull the latest changes if it does
if [ ! -d "$REPO_DIR/.git" ]; then
    # Clone the repository
    echo "Cloning repository $REPO_NAME..."
    git clone "$REPO_URL" "$REPO_DIR"
else
    # Pull the latest changes
    echo "Repository $REPO_NAME already exists. Pulling latest changes..."
    git -C "$REPO_DIR" pull
fi

echo "Repository $REPO_NAME fetch complete."
