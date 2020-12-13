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
WELCOME_URL=https://dxc-technology.github.io/about-devops-dojo/katacoda/os1-welcome/

if [ "$DEBUG" = false ] ; then
  CURL_NODEBUG="-sS"
fi

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

echo -e "${COLLOGS}Fetching your details from GitHub...${COLRESET}"
USER_JSON=$(curl ${CURL_NODEBUG} -H "Authorization: token ${TOKEN}" -H "$GITHUBAPIHEADER" -X GET ${GITHUBAPIURL}/user)

SHORTNAME=$(echo $USER_JSON | jq -r '.login')
export SHORTNAME
echo "export SHORTNAME=${SHORTNAME}" > /tmp/shortname.txt

EMAIL=$(echo $USER_JSON | jq -r '.email//empty')
if [ -z "$EMAIL" ]; then
  EMAIL=${SHORTNAME}@noemail.com
fi
export EMAIL

git config --global user.email "${EMAIL}"

# Check if repository already exists and properly populated
echo -e "${COLLOGS}"
curl $CURL_NODEBUG -H "Authorization: token $TOKEN" -H "$GITHUBAPIHEADER" -X GET ${GITHUBAPIURL}/repos/$SHORTNAME/$REPO/contents/Jenkinsfile | grep "Not Found"
REPO_DOES_NOT_EXIST=$?
if [ $REPO_DOES_NOT_EXIST -eq 0 ]; then
  echo -e "${COLRESET}> I'm confused..."
  echo -e "> I was expecting to find the $REPO repository under your GitHub username and I didn't, or the content does not look right."
  echo -e "> That must be me. But just in case:"
  echo -e "> - Close this Katacoda window: the environment will expire soon and you need ample time to complete the module"
  echo -e "> - Go through the Welcome module which will set everything up for you:"
  echo -e "> $WELCOME_URL"
  exit 1
fi

# 
# Clone Pet Clinic locally
#
echo -e "${COLINFO}Cloning $REPO Git repository...${COLRESET}"
echo -e "${COLLOGS}"
cd ~
rm -fR $REPO
git clone https://${SHORTNAME}:${TOKEN}@${GITHUB}/${SHORTNAME}/${REPO}.git
echo -e "${COLRESET}"

touch /tmp/ready

echo -e "${COLINFO}You are all set! Click on 'CONTINUE'.${COLRESET}"
