#!/bin/bash

#
# Globals
#
DEBUG=false
GITHUB="github.com"
GITHUBAPIURL="https://api.github.com"
COLQUESTION="\u001b[36m"
COLINFO="\u001b[37m"
COLLOGS="\u001b[35m"
COLRESET="\u001b[m"
REPO=pet-clinic
ORGREPO=dxc-technology

if [ "$DEBUG" = false ] ; then
  CURL_NODEBUG="-sS"
fi

# Install Python pre-req
echo -e "${COLINFO}Installing dependencies...${COLRESET}"
2>/dev/null 1>/dev/null python3 -m pip install pyyaml requests

#
# Ask for GitHub PAT
#
echo -e "${COLQUESTION}Please enter your ${GITHUB} Personal Access Token:${COLRESET}"
read TOKEN
export TOKEN

check_credentials()
{
  curl ${CURL_NODEBUG} -H "Authorization: token $TOKEN" -H "Accept: application/vnd.github.v3+json" -X GET ${GITHUBAPIURL} | grep "current_user_url"
  CREDS_NOT_OK=$?
  if [ $CREDS_NOT_OK -ne 0 ]; then
    echo -e "${COLQUESTION}Error: it seems that your credentials are invalid. Please use your GitHub user account and a Personal Access Token with 'repo' and 'admin:repo_hook' scopes at https://github.com/settings/tokens/new ${COLRESET}"
    exit -1
  fi
}
check_credentials

echo -e "${COLLOGS}Fetching your details from GitHub...${COLRESET}"
USER_JSON=$(curl ${CURL_NODEBUG} -H "Authorization: token ${TOKEN}" -H "Accept: application/vnd.github.v3+json" -X GET ${GITHUBAPIURL}/user)

SHORTNAME=$(echo $USER_JSON | jq -r '.login')
export SHORTNAME

# Provision user stories in GitHub
python3 ./github-issues.py github-issues.yaml

echo -e "${COLINFO}Improvement theme added to the backlog: https://${GITHUB}/${SHORTNAME}/pet-clinic/issues${COLRESET}"

touch /tmp/userstoriesadded.txt
