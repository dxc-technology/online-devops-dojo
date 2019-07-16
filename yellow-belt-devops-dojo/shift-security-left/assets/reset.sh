#
# Reset GitHub repository back to the first commit
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

if [ -f /tmp/jenkins_ready ]; then
    # We have user's ID and PAT
    git config --global push.default simple
    cd ~/pet-clinic && git rev-list --max-parents=0 HEAD | xargs git reset --hard && git push --force
    git pull
    cd -
else
    echo "Please execute the prepare.sh script before"
fi