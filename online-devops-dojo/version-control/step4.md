# Add, commit and push

![Dan](../../assets/online-devops-dojo/version-control/dan.png)

> Let's add the change to the staging area. In other words, that we have marked a modified file in its current version to go into our next commit snapshot.
> Then, let's commit locally and push back to our GitHub repository

## Steps

* Add to modified files to the staging area: `git add *`{{execute}}
* Now the changes are put to staging area and are ready to be committed. Let's check the status before committing: `git status`{{execute}}
* Let's commit in our local repository: `git commit -m "#1: add support for horses in database initialization"`{{execute}}
  * Alternatively, you can also try simply `git commit`{{execute}}: this will open an editor to enter a more detailed commit message.
* Push the changes back to the central repository: `git push -u origin us-1-horse`{{execute}}

The changes are pushed to GitHub, as part of the feature branch which you named `us-1-horse`. 
