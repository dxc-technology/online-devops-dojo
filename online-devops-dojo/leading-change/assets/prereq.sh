#!/bin/bash
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

COLQUESTION="\u001b[36m"
COLRESET="\u001b[m"
COLINFO="\u001b[37m"

echo -e "${COLINFO}Installing dependencies...${COLRESET}"
2>/dev/null 1>/dev/null python3 -m pip install pyyaml

# if learner doesn't enter name, default will be set in dialog.py
echo  "Please enter your first name:"
read FIRSTNAME

echo $FIRSTNAME > /tmp/firstname.txt

echo -e "${COLINFO}You are all set! Click on 'CONTINUE'.${COLRESET}"
