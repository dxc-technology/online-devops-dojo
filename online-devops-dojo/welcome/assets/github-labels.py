#!/usr/bin/python3
# Python helper to create labels in a Github repo

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
    print("   Usage: " + sys.argv[0] + " github-labels.yaml")
    sys.exit(0)

def remove_all_labels(repo):
    # Remove all labels in a repo
    response = requests.get(baseurl + "/repos/" + repo + "/labels", 
        headers=headers, 
        auth=(user, token))
    if response.status_code != 200:
        # An error occured
        print(COLINFO + "Error getting labels : " + str(response.status_code) + " " + response.text + COLRESET)

    # Iterate and delete all labels
    labels = json.loads(response.text)
    for label in labels:
        response = requests.delete(baseurl + "/repos/" + repo + "/labels/" + label['name'], 
            headers=headers, 
            auth=(user, token))
        if response.status_code != 204:
            # An error occured
            print(COLINFO + "Error deleting label: " + str(response.status_code) + " " + response.text + COLRESET)
        else:
            sys.stdout.write(COLINFO + "." + COLRESET)
            sys.stdout.flush()

def main():
    print(COLINFO + "Configuring GitHub issues labels..." + COLRESET)
    print(COLINFO + "[                     ]" + COLRESET)
    sys.stdout.write("\033[F")
    sys.stdout.write("\033[1C")
    sys.stdout.flush()

    # Command line argument: labels as yaml file
    labels_file = sys.argv[1]

    # read the labels
    try:
        labels = yaml.load_all(open(labels_file, 'r'), Loader=yaml.FullLoader)
    except yaml.YAMLError as exc:
        print(COLINFO + exc + COLRESET)
    
    remove_all_labels(repo)

    # Populate the labels
    for label in labels:
        payload = json.dumps({
            "name" : label['name'],
            "description": label['description'],
            "color" : label['color']
            })
        response = requests.post(baseurl + "/repos/" + repo + "/labels", 
            data=payload, 
            headers=headers, 
            auth=(user, token))
        if response.status_code != 201:
            # An error occured
            print(COLINFO + "Error adding label " + label['name'] + ": " + str(response.status_code) + " " + response.text + COLRESET)
        else:
            sys.stdout.write(COLINFO + "." + COLRESET)
            sys.stdout.flush()
    print(COLRESET)

main()
