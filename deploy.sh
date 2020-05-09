#!/bin/sh

set -e

echo "Cleaning Publish Folder"

rm -r ./public/*

echo "Running Hugo Build"

env HUGO_ENV="production" hugo --gc --minify -t academic -b https://akleinloog.github.io

cd public

echo "Adding changes to git"

git add .

msg="regenerating site content $(date)"

git commit -m "$msg"

echo "Pushing to master"

git push origin master

cd ..

echo "Deployment Finished"