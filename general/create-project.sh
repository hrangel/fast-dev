#!/bin/sh
project_folder=${PWD##*/}
echo "Starting ENV for new project $project_folder"

git init
git checkout -b development
git checkout -b staging
git checkout -b live
if [ $# -gt 0 ]; then
  team_id=$1
  git checkout -b $team_id
fi
git checkout development

if [ $# -gt 1 ]; then
  BASE_GIT=$2
  if [ -z ${BASE_GIT+x} ]; then
    echo "Couldn't find Base Git ADDRESS"
  else
    git_final_address="$BASE_GIT$project_folder"
    git remote add origin $BASE_GIT
  fi
fi

if [ -z ${BASE_GIT+x} ]; then
  echo "Couldn't find Base Git ADDRESS"
else
  git_final_address="$BASE_GIT$project_folder"
  git remote add origin $BASE_GIT
fi