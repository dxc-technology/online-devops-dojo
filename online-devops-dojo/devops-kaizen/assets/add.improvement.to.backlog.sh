#!/bin/bash

#
# Globals
#
GITHUB="github.com"
DEBUG=false
COLQUESTION="\u001b[36m"
COLINFO="\u001b[37m"
COLLOGS="\u001b[35m"
COLRESET="\u001b[m"

#
# Ask for GitHub PAT
#
echo -e "${COLQUESTION}Please enter your ${GITHUB} Personal Access Token:${COLRESET}"
read TOKEN
export TOKEN

echo -e "${COLLOGS}Fetching your details from GitHub...${COLRESET}"

SHORTNAME=$(curl ${CURL_NODEBUG} -H "Authorization: token ${TOKEN}" -X GET https://${GITHUB}/api/v3/user | jq -r '.login')
export SHORTNAME

# Provision user stories in GitHub
python3 ./github-issues.py github-issues.yaml

echo -e "${COLINFO}Improvement theme added to the backlog: https://${GITHUB}/${SHORTNAME}/pet-clinic/issues${COLRESET}"

touch /tmp/userstoriesadded.txt
