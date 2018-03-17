#!/bin/sh
project_folder=${PWD##*/}
echo "Setup GIT for $project_folder"

cd $project_folder

git init
git checkout -b staging
git checkout -b live
git checkout -b development

echo "GIT initialized & branches (development, staging, live) on $project_folder"