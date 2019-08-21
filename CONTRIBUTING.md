# Contributing to the Online DevOps Dojo

We :heart: [Pull Requests](https://help.github.com/articles/about-pull-requests/) for fixing or adding content. Thanks for your contribution!

For small changes, you can simply use the "Edit" button to update the Markdown file or any of the dialog, and start
the [pull request](https://help.github.com/articles/about-pull-requests/) process easily. You can use the preview tab in GitHub to make sure that it is properly formatted before committing. Once the pull request is placed, review the results of the pipeline and correct any mistake that is reported.

If you plan to contribute often or have a larger change to make, it is best to setup an environment for contribution. This is what the rest of this page is about.

# Development Environment Setup

This guide provides steps to setup a dedicated environment for DevOps Dojo development. It includes Git and Katacoda related instructions.

## Prerequisites

Before you get started make sure to perform the one time setup:
* [GitHub Repository Clone](#github-repository-clone)
* [Katacoda Setup](#katacoda-setup)
* [GitHub Webhook Setup](#github-webhook-setup)

## Development Process

Steps below illustrate how to work on a new DevOps Dojo feature. See [Katacoda and branches](#katacoda-and-branches)
section for more details why the development is done directly on fork's `master`.

1. Fetch latest changes from main repository:
   ```
   git fetch upstream
   ```
2. Reset your fork's `master` branch to match exactly upstream `master`:
   ```
   git checkout master
   git reset --hard upstream/master
   git push --force
   ```
   **IMPORTANT**: Do it only once, when you start working on new feature as
   the above commands will overwrite completely your `master` content.
3. Hack, hack, hack, and commit your changes to Git:
   ```
   # hack, hack, hack
   git add ...
   git commit ...
   git push
   ```
6. Your changes should be visible in Katacoda at h&#8203;ttps://katacoda.com/your_katacoda_user
7. To continue development of your feature:
   ```
   # hack, hack, hack
   git add ...
   git commit ...
   git push
   ```
8. Open a new Pull Request to the main repository using your `master` branch

### Katacoda and Branches

Katacoda only works with `master` branch. Therefore you will use your fork's
`master` branch to preview your work in Katacoda. To make the Pull Requests
and merges easier, at the beginning of each feature development we will reset
your `master` to match exactly the `master` of the main repository.

If you have reasons to not reset your fork's `master` branch, you can use
feature branches, and then merge their content to your `master` and create
Pull Requests out of the feature branch:

```
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

## GitHub Repository Clone

DevOps Dojo development is managed with one repository:
<!--* https://github.com/dxc-technology/devops-dojo-plans - contains the course outlines
  and module plans-->
* https://github.com/dxc-technology/online-devops-dojo - contains Katacoda
  implementations of the scenarios

To prepare your dedicated GitHub repository:
1. Fork in GitHub https://github.com/dxc-technology/online-devops-dojo
2. Clone *your forked repository* (e.g. https://github.com/jdoe1000/online-devops-dojo) to your workstation
3. Set your remotes as follows:
   ```
   cd online-devops-dojo
   git remote add upstream git@github.com:dxc-technology/online-devops-dojo.git
   git remote set-url upstream --push DISABLED
   ```
   Running `git remote -v` should give something similar to:
   ```
   origin  git@github.com:jdoe1000/online-devops-dojo.git (fetch)
   origin  git@github.com:jdoe1000/online-devops-dojo.git (push)
   upstream        git@github.com:dxc-technology/online-devops-dojo.git (fetch)
   upstream        DISABLED (push)
   ```
   The use of `upstream --push DISABLED` is just a practice preventing those
   with `write` access to the main repository to accidentally push changes
   there.

## Katacoda Setup

katacoda.com is lab environment used by Online DevOps Dojo that allows students to
have dedicated environments for their class right in the browser.

1. Sign up for new account on https://katacoda.com
2. If that is your first visit go to _Claim Your Profile_ page and provide your
   username and name. Make sure to `SAVE` and then abort GitHub configuration
   as it does not allow to configure a non-public repository.
3. Go to _Your Profile_ page and then click on _Settings_ icon in the middle of
   the page
4. Set _Private Git Repository_ to `Yes`
5. Set _Git Scenario Repository_ to the address of your fork (e.g.
   https://github.com/jdoe1000/online-devops-dojo)
6. Make sure to click on `SAVE` button
7. Do not close this window as we will need the values from _Git Deploy Key_
   and _Git Webhook Secret_

## GitHub Webhook Setup

We now need to configure GitHub repository hook so that Katacoda is notified
each time you push updates to your repository.

1. Open new browser window and go to your fork's URL (e.g. https://github.com/jdoe1000/online-devops-dojo)
2. Open the repository _Settings_ page tab and then _Deploy keys_ (left navigation)
3. Click on _Add deploy key_ button and use the following information to set it up:
   * _Title_: `katacoda.com`
   * _Key_: paste the _Git Deploy Key_ value from your Katacoda settings page
   * _Allow write access_: leave unchecked
4. Click on _Add deploy key_ button
5. Click on _Webhooks_ (left navigation)
6. Click on _Add webhook_ button and use the following information to set it up:
   * _Payload URL_: https://editor.katacoda.com/scenarios/updated
   * _Content type_: `application/json`
   * _Secret_: paste the _Git Webhook Secret_ value from your Katacoda settings page
   * _Which events ..._: `Just the push event`
7. Click on _Add webhook_ button to create it

If all the setup is done correctly you should be able to access your Katacoda environment at:

h&#8203;ttps://katacoda.com/your_katacoda_user

# Spell Check

Spell check is performed using [Markdown Spell Check \(mdspell\)](https://www.npmjs.com/package/markdown-spellcheck). A spell checking failure in the pipeline will block a merge.  To identify the failure, open the Jenkins pipeline where the failure occurred (click the red X in the GitHub Pull Request), click on the *Spell Check* step, and review the error in the output log.

The system is currently set to validate against a *US English* dictionary.

In general terms, to ignore a word or phrase which is throwing off the spell checker, you add it to the [.spelling](.spelling) ignore file.  This will tell `mdspell` to ignore any and all instances of that word.  **This file is case sensitive.**

:dart: **Goal**: To have as few rows in `.spelling` as possible. Only add to `.spelling` when absolutely necessary.

When you already have a pull request open from your fork, any additional commits to your fork will trigger another pipeline build on the same PR. In this way, you can keep fixing the spelling until the pipeline passes, which will release the PR for merging.

Here are some tips to address spell checking failures:

- Have a typo? Fix it! :smile:
- Proper Names
  - Some proper names are not recognized. When a new name triggers a spell check failure, add it to the `.spelling` file in the "Proper Names" section. The value of this is later usage of the person's name will also then be validated.
- Proper Nouns / Vendor Names / Product Names
  - These should be placed in the `.spelling` file with the correct vendor spelling and capitalization. This will then (correctly) trigger failure if the incorrect capitalization is used.  (e.g., if JFrog is placed in `.spelling`, but content is put through the pipeline spelling it with a lowercase F, this will trigger a failure, and is an accurate error which should be fixed because the vendor calls themselves [JFrog](https://jfrog.com/))
- Lowercase vs. capitals
  - Putting a word in `.spelling` as only lowercase will allow it to work for both lowercase usage and where the first letter is capitalized. (There is no need to put both *Onboarding* and *onboarding* in the `.spelling` file.) If however, you want to force only the capital letter version (i.e., proper nouns), use only the one with the capital letter.
- Acronyms
  - All capital letter acronyms (e.g., AWS) are automatically ignored (`mdspell -a`). If you have a mixed case acronym (e.g., PoC), you will have to add it to the `.spelling` file or wrap it in Markdown backticks.
- Code, Variables, or Complex Abbreviations
  - Any type of code or mixed acronym can be placed within a Markdown code fence block or simple code notation using backticks. This will thus infer it is code, and the spell checker will ignore it.
- URLs
  - Unfortunately, linking to a URL by providing the URL in content will cause a spell check failure. To work around this, either refer to the web site without using the URL, or add the URL to the `.spelling` file.

If you have a spell checking failure you can't figure out how to fix, [open an issue to request help](https://github.com/dxc-technology/online-devops-dojo/issues/new) or add a comment to your pull request.
