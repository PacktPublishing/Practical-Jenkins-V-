#!/bin/bash

git_namespace="practicaljenkins"
api_token="20fda2a6ed2ff7a8cf9db9dd50a0c2b0"
curl -s "https://api.github.com/users/$git_namespace/repos" | jq -r '.[].name' > repo_list

for repo_name in `cat repo_list`
do
    if [[ $repo_name = *"-website"* ]];
    then
      echo "Creating/Updating pipeline for project $repo_name..."
      cp config.xml config_$repo_name.xml
      full_repo_name=$git_namespace"/"$repo_name
      sed -i "s|REPO_FULL_NAME|$full_repo_name|" "config_$repo_name.xml"
      if java -jar jenkins-cli.jar -auth admin:$api_token -s http://localhost:8080 get-job $repo_name-prod-pipeline > /dev/null 2>&1
      then
          java -jar jenkins-cli.jar -auth admin:$api_token -s http://localhost:8080 update-job $repo_name-prod-pipeline < config_$repo_name.xml
      else
          java -jar jenkins-cli.jar -auth admin:$api_token -s http://localhost:8080 create-job $repo_name-prod-pipeline < config_$repo_name.xml
      fi
      rm -rf config_$repo_name.xml
    fi
done

rm -rf repo_list
