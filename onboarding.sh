#!/bin/sh
base_dir=$HOME
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
user_name=who | grep "console" | cut -d" " -f1
mkdir -p "$base_dir/fast-dev"
chmod -R 777 ~/fast-dev
cp -a "$SCRIPT_DIR/general/." "$base_dir/fast-dev/general"

FILE_RELATIVE="fast-dev/.bash_profile"
FILE="$base_dir/$FILE_RELATIVE"
if [ ! -f $FILE ]; then
  # ask for BitBucket Username
  BITBUCKET_USERNAME=""
  while [ "$BITBUCKET_USERNAME" == "" ]; do
    read 'BITBUCKET_USERNAME?Bitbucket Username: '
  done
  GITHUB_USERNAME=""
  read "GITHUB_USERNAME?Github Username (enter for $BITBUCKET_USERNAME): "
  if [ "$GITHUB_USERNAME" == "" ]; then
    GITHUB_USERNAME="$BITBUCKET_USERNAME"
  fi

  BASE_GIT="https://$BITBUCKET_USERNAME@bitbucket.org/"
  echo "source ~/fast-dev/general/.bash_profile" >> $FILE
  echo "export BITBUCKET_USERNAME=$BITBUCKET_USERNAME" >> $FILE
  echo "export GITHUB_USERNAME=$GITHUB_USERNAME" >> $FILE
  echo "export BASE_GIT=$BASE_GIT" >> $FILE
fi

onboarding_source="source ~/$FILE_RELATIVE"
main_profile="$base_dir/.bash_profile"
result=$(egrep -R ".*$onboarding_source.*" $main_profile)

if [ "$result" == "" ]; then
  echo "$onboarding_source" >> $base_dir/.bash_profile
fi

chmod u+x $FILE
source $FILE

echo "Default ENV Setup DONE"