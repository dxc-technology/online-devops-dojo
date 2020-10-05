#!/usr/bin/python3
# Python helper to create GitHub issues, except if they already exist

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

import os, sys, json, requests, yaml

# Color constants
# Reference: https://gist.github.com/chrisopedia/8754917
COLINFO="\033[0;35m"
COLRESET="\033[m"

baseurl = 'https://api.github.com'
headers = {"Content-Type": "application/json", "Accept": "application/vnd.github.symmetra-preview+json", "Accept": "application/vnd.github.v3+json"}
user = os.environ['SHORTNAME']
token = os.environ['TOKEN']
repo = user + '/pet-clinic'

if len(sys.argv) != 2:
    print("   Usage: " + sys.argv[0] + " github-issues.yaml")
    sys.exit(0)

def main():
    print(COLINFO + "Create user stories as GitHub issues..." + COLRESET)

    # Command line argument: issues as yaml file
    issues_file = sys.argv[1]

    # read the issues
    try:
        issues = yaml.load_all(open(issues_file, 'r'), Loader=yaml.FullLoader)
    except yaml.YAMLError as exc:
        print(COLINFO + exc + COLRESET)
    
    # Create the issues
    for issue in issues:
        # Avoid creating an issue which is already there (same title) 
        issue_already_exists = False
        # List all open issues
        payload = json.dumps({
            "state" : "open"
            })
        sys.stdout.write(COLINFO + "." + COLRESET)
        sys.stdout.flush()
        response = requests.get(baseurl + "/repos/" + repo + "/issues", 
            data=payload, 
            headers=headers, 
            auth=(user, token))
        if response.status_code == 200:
            issues_opened = json.loads(response.text)
            for issue_found in issues_opened:
                if (issue_found['title'] == issue['title']):
                    # This issue has the same title has the one we want to create. Skipping.
                    issue_already_exists = True

        if (not issue_already_exists):
            payload = json.dumps({
                "title" : issue['title'],
                "body": issue['body'],
                "labels" : issue['labels']
                })
            response = requests.post(baseurl + "/repos/" + repo + "/issues", 
                data=payload, 
                headers=headers, 
                auth=(user, token))
            if response.status_code != 201:
                # An error occured
                print(COLINFO + "Error adding issue " + issue['title'] + ": " + str(response.status_code) + " " + response.text + COLRESET)
            else:
                sys.stdout.write(COLINFO + "." + COLRESET)
                sys.stdout.flush()
    print(COLRESET)


main()

