#!/bin/sh
function usage()
{
    echo "Here is how to create new bit-bucket repository"
    echo ""
    echo "./create-new-bitbucket.sh"
    echo "\trepository_slug"
    echo "\t-h --help"
    echo "\t--user=BitBucketUser"
    echo "\t--name=name"
    echo "\t--description=description"
    echo "\t--team=team"
    echo "\t--project=project_key"
    echo ""
}

repo_slug=""
user=$BITBUCKET_USERNAME
name=""
description=""
team=""
project_key=""
remote="true"

if [ "$1" == "" ]; then
  usage
  exit 1
fi  

while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    if [ "$PARAM" != "" ] && [ "$VALUE" == "" ]; then
      VALUE=$PARAM
      PARAM=$""
    fi
    case $PARAM in
        -h | --help)
          usage
          exit
          ;;
        -u | --user)
          user=$VALUE
          ;;
        -n | --name)
          name=$VALUE
          ;;
        -d | --desc)
          description=$VALUE
          ;;
        -t | --team)
          team=$VALUE
          ;;
        -p | --project)
          project_key=$VALUE
          ;;
        -r | --remote)
          remote=$VALUE
          ;;
        *)
          repo_slug=$VALUE
          ;;
    esac
    shift
done

if [ "$repo_slug" == "" ]; then
  echo "ERROR: unknown repo_slug"
  usage
  exit 1
fi  

if [ "$user" == "" ]; then
  echo "ERROR: unknown user"
  usage
  exit 1
fi  

posted_data="\"scm\": \"git\", \"name\": \"$name\", \"description\": \"$description\""
if [ "$project_key" != "" ]; then
  posted_data="$posted_data, \"project\": { \"key\": \"$project_key\" }"
fi

if [ "$team" == "" ]; then
  final_url="https://api.bitbucket.org/2.0/repositories/$user"
else
  final_url="https://api.bitbucket.org/2.0/repositories/$user/$team"
fi
final_url="$final_url/$repo_slug"

curl_result=$(curl --silent --user $user -X POST -H "Content-Type: application/json" -d "{ $posted_data }" $final_url)
clone_url=$(echo $curl_result | jq '.links.clone[0].href')

# echo $clone_url
if [ $clone_url ] && [ "$clone_url" != "null" ] && [ "$clone_url" != "" ]; then
  echo "Project '$repo_slug' created on Bitbucket!"
  if [ "$remote" == "true" ] || [ "$remote" == "1" ]; then
    clone_url=$(echo "${clone_url:1:${#clone_url}-2}")
    git remote add origin $clone_url
    echo "Remote 'origin' for project '$repo_slug' added!"
  fi  
else
  echo "Error creating project '$repo_slug'"
  echo $curl_result
fi