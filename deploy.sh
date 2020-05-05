#!/bin/sh

set -e

echo "Cleaning Publish Folder"

rm -r ./public/*

echo "Running Hugo Build"

hugo -t academic

cd public

echo "Adding changes to git"

git add .

msg="regenerating site content $(date)"

git commit -m "$msg"

echo "Pushing to master"

git push origin master

cd ..

echo "Deployment Finished"