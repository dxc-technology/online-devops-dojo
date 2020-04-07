# Peer review

![Dan](../../assets/online-devops-dojo/version-control/dan.png)

> OK, you submitted your changes. They are ready to be reviewed by someone
> before they get merged.
> Let's ask for a lightweight peer review within the pull request.

## Steps

* In the pull request you have just created, enter a comment to ask for a review from **Paulo**, our product owner: `/paulo - can you please review this pull request?`{{copy}} (It's important you type the comment exactly like that for the lab to work - you may want to copy/paste the comment).
* Paulo will provide its comments.
* Back to the editor, change the code according to Paulo's comments.
* Let's push the code back to GitHub:
  * `git status`{{execute}}: where are we? What are the files which have been changed?
  * `git add .`{{execute}}: adding all the files in the current directory (`.`) in the staging area
  * `git commit -m "Taking Paulo's comments into account"`{{execute}}: commit the changes in the local repository
  * `git push`{{execute}}: push the changes back to GitHub

* From the pull request, ask Paulo for another review by adding a new comment: `/paulo - can you check now?`{{copy}}
* Once Paulo is happy with the changes, **Paulo** will merge the pull request.

🤖 **Note**: Paulo is a bot, implemented as a "[GitHub app](https://developer.github.com/apps/about-apps/)". Its code is here: <https://github.com/dxc-technology/online-devops-dojo>.
