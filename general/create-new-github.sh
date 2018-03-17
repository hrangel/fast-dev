#!/bin/sh

function usage()
{
    echo "Here is how to create new bit-bucket repository"
    echo ""
    echo "./create-new-github.sh"
    echo "\trepo_name"
    echo "\t-h --help"
    echo "\t--user=GithubUser"
    echo "\t--description=description"
    echo "\t--team=team"
    echo "\t--org=org"
    echo "\t--private=project_key"
    echo ""
}

repo_name=""
user=$GITHUB_USERNAME
description=""
team=""
org=""
private="false"
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
    # echo "param:$PARAM||"
    # echo "value:$VALUE||"

    case $PARAM in
        -h | --help)
          usage
          exit
          ;;
        -u | --user)
          user=$VALUE
          ;;
        -d | --desc)
          description=$VALUE
          ;;
        -t | --team)
          team=$VALUE
          ;;
        -o | --org)
          org=$VALUE
          ;;
        --private)
          private=$VALUE
          ;;
        -r | --remote)
          remote=$VALUE
          ;;
        *)
          repo_name=$VALUE
          ;;
    esac
    shift
done

if [ "$repo_name" == "" ]; then
  echo "ERROR: unknown repo_name"
  usage
  exit 1
fi  

if [ "$user" == "" ]; then
  echo "ERROR: unknown user"
  usage
  exit 1
fi  

posted_data="\"name\": \"$repo_name\", \"description\": \"$description\""
if [ "$team" != "" ]; then
  posted_data="$posted_data, \"team_id\": \"$team\""
fi
if [ "$private" == "true" ]; then
  posted_data="$posted_data, \"private\": true"
else
  posted_data="$posted_data, \"private\": false"
fi

if [ "$org" == "" ]; then
  final_url="https://api.github.com/user/repos"
else
  final_url="https://api.github.com/orgs/$org/repos"
fi

echo "Creating project on Github: $repo_name"
curl_result=$(curl --silent -u $user $final_url -d "{ $posted_data }")
clone_url_attr=$(echo $curl_result | grep -o "\"clone_url\": \"[^\\\"]*\"")

if [ "$clone_url_attr" == "" ]; then
  echo "Error creating project '$repo_name'"
  echo $curl_result
else
  echo "Project '$repo_name' created on Github!"
  if [ "$remote" == "true" ] || [ "$remote" == "1" ]; then
    base_var=$(echo $clone_url_attr | tr -d '[:space:]')
    base_var_len=${#base_var}
    str_len=`expr $base_var_len - 13 - 1`

    clone_url=${base_var:13:$str_len}
    git remote add origin $clone_url
    echo "Remote 'origin' for project '$repo_name' added!"
  fi  
fi