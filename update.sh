#!/bin/bash

# This script assumes the necessary permissions are in place and Github 
# credentials are set up correctly

repo_url="https://github.com/tr3mulant/multi-host-vps"
repo_dir="multi-host-vps"

# If it exists, change directory to it and pull the latest changes
# Otherwise, let's clone the repo and put it in the repo directory above
if [ -d "$repo_dir"]; then
    echo "Pulling the latest changes from $repo_url"
    cd "$repo_dir" || exit
    git pull origin main
else
    echo "Repository directory $repo_dir not found. Cloning $repo_url to $repo_dir"
    git clone "$repo_url" "$repo_dir"
    cd "$repo_dir" || exit
fi