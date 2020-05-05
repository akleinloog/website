#!/bin/sh

set -e

echo "Cleaning Publish Folder"

rm -r /path/to/dir/*

echo "Running Hugo Build"

# Build the project.
hugo -t academic # if using a theme, replace with `hugo -t <YOURTHEME>`

# Go To Public folder
cd public

echo "Adding changes to git"

# Add changes to git.
#git add .

# Commit changes.
#msg="rebuilding site $(date)"
#if [ -n "$*" ]; then
#	msg="$*"
#fi
#git commit -m "$msg"

echo "Pushing to master"

# Push source and build repos.
#git push origin master