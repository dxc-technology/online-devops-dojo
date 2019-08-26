#!/usr/bin/python3
# Python helper to simulate a dialog
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

import os, sys, time, yaml, random, curses, re, textwrap

firstname=""
# Command line argument: dialog as yaml file
dialog_file = sys.argv[1]

height=0
width=0

# Init color pairs
def setcolors():
    curses.init_pair(1, curses.COLOR_BLACK, curses.COLOR_BLUE) # Speaker name
    curses.init_pair(2, 183, curses.COLOR_BLACK)
    curses.init_pair(3, 119, curses.COLOR_BLACK)
    curses.init_pair(4, 230, curses.COLOR_BLACK)
    curses.init_pair(5, 229, curses.COLOR_BLACK)
    curses.init_pair(6, 230, curses.COLOR_BLACK)
    curses.init_pair(7, 200, curses.COLOR_BLACK)
    curses.init_pair(8, 195, curses.COLOR_BLACK)
    curses.init_pair(9, 233, curses.COLOR_BLACK)
    curses.init_pair(10, 250, curses.COLOR_BLACK)
    curses.init_pair(11, 251, curses.COLOR_BLACK)
    curses.init_pair(12, 252, curses.COLOR_BLACK)
    curses.init_pair(13, 253, curses.COLOR_BLACK)
    curses.init_pair(14, 254, curses.COLOR_BLACK)
    curses.init_pair(15, 255, curses.COLOR_BLACK)       # Prompts

# Each speaker speaks with a different color, white by default
def color(speaker):

    return {
        'paulo': 2,
        'santhosh': 3,
        'adam': 4,
        'dan': 5,
        'tina': 6,
        'selma': 7,
        'chun': 8,
        'hal': 9,
        'brenda': 10,
        'charlie': 11,
        'team': 12,
    }.get(speaker.lower(),'2')

# Type text like a human
def human_type(stdscr, speaking, firstname, text, color, dialog_id):
    # Test if we are at bottom of screen
    text = text.replace("[student]", firstname)
    lines = text.count("\n") + 1
    y, x = stdscr.getyx()
    height, width = stdscr.getmaxyx()
    if y + lines + 2 > height:
        wait_for_enter(stdscr, dialog_id)
        stdscr.clear()
    # Speaker
    stdscr.addstr(speaking + ">", curses.color_pair(1))
    stdscr.addstr(" ")
    # do not wait for input when calling getch
    stdscr.nodelay(1)
    nodelay = False
    for letter in text:
        stdscr.refresh()
        try:
            stdscr.addch(letter, curses.color_pair(color))
            k = stdscr.getch()
            # Skip to end of sentence with 'n'
            if k == 110:
                nodelay = True
        except curses.error: pass
        if letter == ' ':
            time.sleep(0 if nodelay else 0.07)
        elif (letter == '.' or letter =='?' or letter ==','):
            time.sleep(0 if nodelay else 0.15)
        else:
            time.sleep(0 if nodelay else random.choice([0.01, 0.02]))
    stdscr.nodelay(0)

def redraw_on_resize(stdscr, dialog_id):
    stdscr.clear()
    stdscr.refresh()
    redraw_dialog = 0
    dialogs2 = yaml.load_all(open(dialog_file, 'r'), Loader=yaml.FullLoader)
    for dialog2 in dialogs2:
        height, width = stdscr.getmaxyx()
        stdscr.addstr(dialog2['speaking'] + ">", curses.color_pair(1))
        stdscr.addstr(" ")
        stdscr.addstr(textwrap.fill(dialog2['text'].replace("[student]", firstname), width - len(dialog2['speaking']) - 3), curses.color_pair(color(dialog2['speaking'])))
        stdscr.addstr("\n")
        redraw_dialog = redraw_dialog + 1
        if redraw_dialog >= dialog_id:
            stdscr.addstr("Press enter\n", curses.color_pair(15))
            break

def wait_for_enter(stdscr, dialog_id):
    # Resize before waiting for enter
    try:
        stdscr.addstr("\nPress enter\n", curses.color_pair(15))
    except curses.error: pass
    if curses.is_term_resized(height, width):
            redraw_on_resize(stdscr, dialog_id)
    k = 0
    while (k != 10) and (k != 110):
        k = stdscr.getch()
        if (k == curses.KEY_RESIZE):
            # Resize if window resized waiting for enter
            redraw_on_resize(stdscr, dialog_id)


def main(stdscr):
    setcolors()
    # Get first name of the user
    firstname = ""
    try:
        myfile = open('/tmp/firstname.txt', 'r')
        firstname = myfile.read().replace('\n', '')
    except IOError:
        firstname = "the student"

    # Open the dialog
    try:
        dialogs = yaml.load_all(open(dialog_file, 'r'))
    except yaml.YAMLError as exc:
        print(exc)

    # Find terminal width
    rows, columns = os.popen('stty size', 'r').read().split()

    # Start the dialog
    dialog_id = 0
    for dialog in dialogs:
        dialog_id = dialog_id + 1
        stdscr.refresh()
        height, width = stdscr.getmaxyx()   # Capture size before dialog
        try:
            human_type(stdscr, dialog['speaking'], firstname, textwrap.fill(dialog['text'], width - len(firstname) - 3), color(dialog['speaking']), dialog_id)
        except curses.error:pass
        wait_for_enter(stdscr, dialog_id)

        y, x = stdscr.getyx()
        stdscr.move(y-1,0)
        stdscr.clrtoeol()
        stdscr.refresh()

    # We went through the end of the dialog
    dialog_id = re.search(r'dialog(\d*).yaml', dialog_file)
    if dialog_id:
        open('/tmp/dialog' + dialog_id.group(1) + 'played.txt', 'w')

if __name__ == '__main__':
    curses.wrapper(main)
