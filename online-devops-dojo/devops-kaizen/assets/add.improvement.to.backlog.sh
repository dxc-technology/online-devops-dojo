#!/bin/bash
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
#
# Globals
#
DEBUG=false
GITHUB='github.com'
GITHUBAPIURL='https://api.github.com'
# Explicit header for GitHub API V3 request cf. https://developer.github.com/v3/#current-version
GITHUBAPIHEADER='Accept: application/vnd.github.v3+json'

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

# adding -s to the command line, allows to hide the PAT entered especially during demos
if [ "$1" == "-s" ] ; then
  HIDE_PAT="-s"
fi

#
# Ask for GitHub PAT
#
echo -e "${COLQUESTION}Please enter your ${GITHUB} Personal Access Token:${COLRESET}"
read $HIDE_PAT TOKEN
export TOKEN

check_credentials()
{
  curl $CURL_NODEBUG -H "Authorization: token $TOKEN" -H "$GITHUBAPIHEADER" -X GET ${GITHUBAPIURL} | grep "current_user_url"
  CREDS_NOT_OK=$?
  if [ $CREDS_NOT_OK -ne 0 ]; then
    echo -e "${COLQUESTION}Error: it seems that your credentials are invalid. Please use your GitHub user account and a Personal Access Token with 'repo' and 'admin:repo_hook' scopes at https://github.com/settings/tokens/new ${COLRESET}"
    exit -1
  fi
}
check_credentials

echo -e "${COLLOGS}Fetching your details from GitHub...${COLRESET}"
USER_JSON=$(curl ${CURL_NODEBUG} -H "Authorization: token ${TOKEN}" -H "$GITHUBAPIHEADER" -X GET ${GITHUBAPIURL}/user)

SHORTNAME=$(echo $USER_JSON | jq -r '.login')
export SHORTNAME

# Provision user stories in GitHub
python3 ./github-issues.py github-issues.yaml

echo -e "${COLINFO}Improvement theme added to the backlog: https://${GITHUB}/${SHORTNAME}/pet-clinic/issues${COLRESET}"

touch /tmp/userstoriesadded.txt
