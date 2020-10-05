#!/usr/bin/python3
# Python helper to create GitHub issues, except if they already exist

import os
import sys
import json
import requests
import yaml

# Color constants
# Reference: https://gist.github.com/chrisopedia/8754917
COLINFO = "\033[0;35m"
COLRESET = "\033[m"

baseurl = 'https://github.com/api/v3'
headers = {"Content-Type": "application/json"}
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

    # ID of the issue which was just created
    prev_issue = 0
    # List all open issues
    payload = json.dumps(
        {
            "state": "open"
        })
    sys.stdout.write(COLINFO + "." + COLRESET)
    sys.stdout.flush()
    response = requests.get(baseurl + "/repos/" + repo + "/issues",
                            data=payload,
                            headers=headers,
                            auth=(user, token))
    issues_opened = []
    if response.status_code == 200:
        issues_opened = response.json()
    # Create the issues
    for issue in issues:
        # Avoid creating an issue which is already there (same title)
        issue_already_exists = False
        for existing_issue in issues_opened:
            if (existing_issue['title'] == issue['title']):
                # This issue has the same title has the one we want to create. Skipping.
                issue_already_exists = True

        if (not issue_already_exists):
            payload = json.dumps(
                {
                    "title": issue['title'],
                    "body": issue['body'].replace("[previous_issue]", str(prev_issue)),
                    "labels": issue['labels']
                })
            response = requests.post(baseurl + "/repos/" + repo + "/issues",
                                     data=payload,
                                     headers=headers,
                                     auth=(user, token))
            if response.status_code != 201:
                # An error occurred
                print(COLINFO + "Error adding issue " + issue['title'] + ": " + str(response.status_code) + " " + response.text + COLRESET)
            else:
                issue_data = response.json()
                prev_issue = issue_data['number']
                sys.stdout.write(COLINFO + "." + COLRESET)
                sys.stdout.flush()
    print(COLRESET)


main()
