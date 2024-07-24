#!/bin/bash

# GitHub API URL
API_URL="https://api.github.com"

# GitHub username and personal access token from environment variables
USERNAME=${username}
TOKEN=${token}

# User and Repository information
REPO_OWNER=$1
REPO_NAME=$2

# Function to make a GET request to the GitHub API
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"

    # Send a GET request to the GitHub API with authentication
    curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

# Function to list users with read access to the repository
function list_users_with_read_access {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    # Fetch the list of collaborators on the repository
    collaborators="$(github_api_get "$endpoint")"

    # Output raw response for debugging
    echo "Raw response: $collaborators"

    # Parse the JSON response to find users with read access
    collaborators_read_access=$(echo "$collaborators" | jq -r '.[] | select(.permissions.pull == true) | .login')

    # Display the list of collaborators with read access
    if [[ -z "$collaborators_read_access" ]]; then
        echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
        echo "$collaborators_read_access"
    fi
}

# Main script
if [[ -z "$USERNAME" || -z "$TOKEN" ]]; then
    echo "Error: GitHub username and/or token not set."
    exit 1
fi

echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access

