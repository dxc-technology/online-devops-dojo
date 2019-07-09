#
# Reset GitHub repository back to the first commit
#
if [ -f /tmp/jenkins_ready ]; then
    # We have user's ID and PAT
    git config --global push.default simple
    cd ~/pet-clinic && git rev-list --max-parents=0 HEAD | xargs git reset --hard && git push --force
    git pull
    cd -
else
    echo "Please execute the prepare.sh script before"
fi