#!/bin/bash

# Path to the repository list file
REPO_LIST_FILE="./repos_list.txt"

# Path to the template script
TEMPLATE_SCRIPT="./git_fetcher.sh"


# Check if the repository list file exists
if [ ! -f "$REPO_LIST_FILE" ]; then
    echo "Repository list file not found: $REPO_LIST_FILE"
    exit 1
fi

# Check if the template script exists and is executable
if [ ! -f "$TEMPLATE_SCRIPT" ] || [ ! -x "$TEMPLATE_SCRIPT" ]; then
    echo "Template script not found or not executable: $TEMPLATE_SCRIPT"
    exit 1
fi

# Iterate over each line in the repository list file
while IFS= read -r repo_url || [[ -n "$repo_url" ]]; do
    # Trim potential Windows carriage returns
    repo_url=$(echo "$repo_url" | tr -d '\r')

    if [ -n "$repo_url" ]; then  # Skip empty lines
        echo "Processing repository: $repo_url"
        "$TEMPLATE_SCRIPT" "$repo_url"
    fi
done < "$REPO_LIST_FILE"

echo "All repositories processed."
