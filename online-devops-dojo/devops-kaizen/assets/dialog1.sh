#!/bin/bash

# clear the screen
clear

#
# Globals
#
COLINFO="\u001b[37m"
COLRESET="\u001b[m"

echo -e "${COLINFO}Installing dependencies...${COLRESET}"

# Install python pre-reqs
2>/dev/null 1>/dev/null python3 -m pip install pyyaml 

#play the dialog
TERM=xterm-256color python3 dialog.py dialog1.yaml

clear
echo "Click on 'CONTINUE'."
