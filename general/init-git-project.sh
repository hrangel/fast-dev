#!/bin/sh
project_folder=${PWD##*/}
echo "Setup GIT for $project_folder"

git init
git checkout -b development
git checkout -b staging
git checkout -b live
git checkout development

echo "GIT initialized & branches (development, staging, live) on $project_folder"