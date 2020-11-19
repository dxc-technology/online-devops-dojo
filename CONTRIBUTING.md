# Contributing to the Online DevOps Dojo training

We :heart: [Pull Requests](https://help.github.com/articles/about-pull-requests/)
for fixing or adding content. Thanks for your contribution!

For small changes, you can simply use the "Edit" button to update the Markdown
file or any of the dialog, and start the
[pull request](https://help.github.com/articles/about-pull-requests/) process
easily. You can use the preview tab in GitHub to make sure that it is properly
formatted before committing. Once the pull request is placed, review the results
of the pipeline and correct any mistake that is reported.

If you plan to contribute often or have a larger change to make, it is best to
setup an environment for contribution. This is what the rest of this page is about.

## Development Environment Setup

This guide provides steps to setup a dedicated environment for DevOps Dojo
development. It includes Git and Katacoda related instructions.

### Prerequisites

Before you get started make sure to perform the one time setup:

* [GitHub Repository Clone](#github-repository-clone)
* [Katacoda Setup](#katacoda-setup)  
* [GitHub Webhook Setup](#github-webhook-setup)

### Development Process

Steps below illustrate how to work on a new DevOps Dojo feature.
See [Katacoda and branches](#katacoda-and-branches)
section for more details why the development is done directly on fork's `master`.

1. Fetch latest changes from main repository:

   ```sh
   git fetch upstream
   ```

1. Reset your fork's `master` branch to match exactly upstream `master`:

   ```sh
   git checkout master
   git reset --hard upstream/master
   git push --force
   ```

   **IMPORTANT**: Do it only once, when you start working on new feature as
   the above commands will overwrite completely your `master` content.
1. Hack, hack, hack, and commit your changes to Git:

   ```sh
   # hack, hack, hack
   git add ...
   git commit ...
   git push
   ```

<!-- Note "h&#8203;ttps" is included as a hidden character to force GitHub-flavored Markdown
     to not render the URL as a link. Team opted for this over code fence. -->
1. Your changes should be visible in Katacoda at h&#8203;ttps://katacoda.com/<your_katacoda_user>
1. To continue development of your feature:

   ```sh
   # hack, hack, hack
   git add ...
   git commit ...
   git push
   ```

1. Open a new Pull Request to the main repository using your `master` branch

#### Katacoda and Branches

Katacoda only works with `master` branch. Therefore you will use your fork's
`master` branch to preview your work in Katacoda. To make the Pull Requests
and merges easier, at the beginning of each feature development we will reset
your `master` to match exactly the `master` of the main repository.

If you have reasons to not reset your fork's `master` branch, you can use
feature branches, and then merge their content to your `master` and create
Pull Requests out of the feature branch:

```sh
git fetch upstream
git checkout -b feature-X upstream/master
# hack, hack, hack
git add ...
git commit ...
git checkout master
git merge feature-X
git push
# changes now visible in Katacoda
git checkout feature-X
git push -u origin feature-X
# you can now open a Pull Request to the main repository using feature-X branch
# finally once all done - delete the branch
git branch -d feature-X
git push --delete feature-X
```

### GitHub Repository Clone

DevOps Dojo development is managed with one repository:
<!--* https://github.com/dxc-technology/devops-dojo-plans - contains
 the course outlines and module plans-->

* [https://github.com/dxc-technology/online-devops-dojo](https://github.com/dxc-technology/online-devops-dojo)
\- contains Katacoda implementations of the scenarios as well as the GitHub app.

To prepare your dedicated GitHub repository:

1. Fork in GitHub [https://github.com/dxc-technology/online-devops-dojo](https://github.com/dxc-technology/online-devops-dojo)
2. Clone *your forked repository* (e.g., h&#8203;ttps://github.com/jdoe1000/online-devops-dojo )
 to your workstation.
3. Set your remotes as follows:

   ```sh
   cd online-devops-dojo
   git remote add upstream git@github.com:dxc-technology/online-devops-dojo.git
   git remote set-url upstream --push DISABLED
   ```

   Running `git remote -v` should give something similar to:

   ```text
   origin  git@github.com:jdoe1000/online-devops-dojo.git (fetch)
   origin  git@github.com:jdoe1000/online-devops-dojo.git (push)
   upstream        git@github.com:dxc-technology/online-devops-dojo.git (fetch)
   upstream        DISABLED (push)
   ```

   The use of `upstream --push DISABLED` is just a practice preventing those
   with `write` access to the main repository from accidentally pushing changes
   there.

### Katacoda Setup

[https://katacoda.com](https://katacoda.com) is lab environment used by Online DevOps Dojo that allows students to have dedicated environments for their class right in the browser.

1. Sign up for new account on [https://katacoda.com](https://katacoda.com)
2. If that is your first visit, go to _Claim Your Profile_ page and provide your
   username and name. Make sure to `SAVE` and then abort GitHub configuration
   as it does not allow to configure a non-public repository.
3. Go to _Your Profile_ page and then click on _Settings_ icon in the middle of
   the page
4. Set _Private Git Repository_ to `Yes`
5. Set _Git Scenario Repository_ to the address of your fork (e.g., h&#8203;ttps://github.com/jdoe1000/online-devops-dojo )
6. Make sure to click on `SAVE` button
7. Do not close this window as we will need the values from _Git Deploy Key_
   and _Git Webhook Secret_

### GitHub Webhook Setup

We now need to configure GitHub repository hook so that Katacoda is notified
each time you push updates to your repository.

1. Open new browser window and go to your fork's URL (e.g., h&#8203;ttps://github.com/jdoe1000/online-devops-dojo )
2. Open the repository _Settings_ page tab and then _Deploy keys_ (left navigation)
3. Click on _Add deploy key_ button and use the following information to set it up:
   * _Title_: `katacoda.com`
   * _Key_: paste the _Git Deploy Key_ value from your Katacoda settings page
   * _Allow write access_: leave unchecked
4. Click on _Add deploy key_ button
5. Click on _Webhooks_ (left navigation)
6. Click on _Add webhook_ button and use the following information to set it up:
   * _Payload URL_: [https://editor.katacoda.com/scenarios/updated](https://editor.katacoda.com/scenarios/updated)
   * _Content type_: `application/json`
   * _Secret_: paste the _Git Webhook Secret_ value from your Katacoda settings page
   * _Which events ..._: `Just the push event`
7. Click on _Add webhook_ button to create it

If all the setup is done correctly you should be able to access your
Katacoda environment at:

> h&#8203;ttps://katacoda.com/<your_katacoda_user>
