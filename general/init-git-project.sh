#!/bin/sh
project_folder=${PWD##*/}
echo "Setup GIT for $project_folder"

if [ -z "$(ls -A $PWD)" ]; then
   git init
   touch readme.md
else
   git init
fi

git add .
git commit -m "First Version"

git checkout -b staging
git checkout -b live
git checkout -b development

echo "GIT initialized & branches (development, staging, live) on $project_folder"