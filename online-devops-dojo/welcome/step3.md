
The **Online DevOps Dojo** has been designed to ensure that as you progress through the module labs on the curriculum, you will be using your own dedicated copy of the "Pet Clinic" application.

As you work through the labs, your progress will be saved to your own copy of the Pet Clinic applications' Git repository. You can consider this copy a sandbox if you will, where you can learn, evaluate, try things out and hopefully have some fun safe in the knowledge that you can't impact any other learners.

However with great power, comes great responsibility. There is a process to set up the environment we need you to follow. The process, apologies in advance, is in itself a learning opportunity - that of learning about GitHub repositories.

### Copy the Pet Clinic application

Usually, when you want to make a copy of a GitHub repository for you to edit, you use the **Fork** function. Forking is the process of making a copy of a Git repository into another account (in this case your account) so that you can add, edit or delete the content in your copy of the repository without impacting any users of the source repository. However, your copy of the repository maintains a relationship back to the source repository, so that changes can be pushed "upstream" using the **Pull Request** function.

In order to further isolate ourselves from the original pet clinic repository, we won't actually use a fork. Instead, we will create a disconnected copy of the repository under your GitHub user account.

* Run the following script to copy the Pet Clinic repository.
(just click on the text below and the command will be run into the Katacoda window - there's no need to copy/paste or type it out yourself; though you might find that manually typing the commands in helps build familiarity [and refine troubleshooting skills when you make typos])

  `./copy-pet-clinic.sh`{{execute}}

The script will ask you for your github.com Personal Access Token. See below for instructions to generate.

### Generate Personal Access Token

1. Create a personal [github.com](https://github.com) account (Sign Up)
1. Log in to [github.com](https://github.com)
1. On any GitHub page, click your profile icon at the top right and then click Settings.
1. On the sidebar menu, click Developer settings and then click Personal access tokens.
1. Click Generate new token.
1. Enter a Token description of your choice.
1. Select `repo` so that the token can read/write in your repository and `admin:repo_hook` so that it can update GitHub repository web hooks. Make sure to select everything within those scopes.
1. Click Generate token.
1. Click the clipboard icon to copy the token in your clipboard.
1. **Make note of the personal access token**. This token will be used throughout the Online DevOps Dojo. Note that it is OK if you lose it, as you can always generate a new one.

💡 **TIP**: 🦊 Firefox user? Use <kbd>CTRL</kbd>+<kbd>INS</kbd> / <kbd>SHIFT</kbd>+<kbd>INS</kbd> to copy/paste your Personal Access Token in the window.
