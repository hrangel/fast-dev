#!/bin/sh
branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
merged=$1
git checkout $merged

if [[ ! $(git merge $branch) ]]; then  
  echo FAIL
else
  if [[ ! $(git push origin $merged) ]]; then  
    echo FAIL
  else
    git checkout $branch
  fi
fi