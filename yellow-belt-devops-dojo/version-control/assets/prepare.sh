#
# Globals
#
GITHUB="github.dxc.com"
DEBUG=false
COLQUESTION="\u001b[36m"
COLINFO="\u001b[37m"
COLLOGS="\u001b[35m"
COLRESET="\u001b[m"
REPO=pet-clinic

if [ "$DEBUG" = false ] ; then
  CURL_NODEBUG="-sS"
fi

#
# Ask for GitHub PAT
#
echo -e "${COLQUESTION}Please enter your ${GITHUB} Personal Access Token:${COLRESET}"
read TOKEN
export TOKEN

echo -e "${COLLOGS}Fetching your details from GitHub...${COLRESET}"

SHORTNAME=$(curl ${CURL_NODEBUG} -H "Authorization: token ${TOKEN}" -X GET https://${GITHUB}/api/v3/user | jq -r '.login')
export SHORTNAME
echo "export SHORTNAME=${SHORTNAME}" > /tmp/shortname.txt

EMAIL=$(curl ${CURL_NODEBUG} -H "Authorization: token ${TOKEN}" -X GET https://${GITHUB}/api/v3/user | jq -r '.email')
if [ -z "$EMAIL" ]; then
  EMAIL=${SHORTNAME}@dxc.com
fi
export EMAIL

git config --global user.email "${EMAIL}"

# Check if repository already exists and properly populated
echo -e "${COLLOGS}"
curl ${CURL_NODEBUG} -H "Authorization: token $TOKEN" -X GET https://${GITHUB}/api/v3/repos/$SHORTNAME/$REPO/contents/Jenkinsfile | grep "Not Found"
REPO_DOES_NOT_EXIST=$?
if [ $REPO_DOES_NOT_EXIST -eq 0 ]; then
  echo -e "${COLRESET}> I'm confused..."
  echo -e "> I was expecting to find the pet-clinic repository under your GitHub username and I didn't, or the content does not look right."
  echo -e "> That must be me. But just in case:"
  echo -e "> - Close this Katacoda window: the environment will expire soon and you need ample time to complete the module"
  echo -e "> - Go through the Welcome module which will set everything up for you: https://github.dxc.com/pages/GDO-CTO/Katacoda/katacoda/welcome/"
  echo -e ""
  exit 1
fi

# 
# Clone Pet Clinic locally
#
echo -e "${COLINFO}Cloning pet-clinic Git repository...${COLRESET}"
echo -e "${COLLOGS}"
cd ~
rm -fR pet-clinic
git clone https://${SHORTNAME}:${TOKEN}@${GITHUB}/${SHORTNAME}/pet-clinic.git
echo -e "${COLRESET}"

touch /tmp/ready

echo -e "${COLINFO}You are all set! Click on 'CONTINUE'.${COLRESET}"
