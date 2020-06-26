# Online DevOps Dojo coach setup

This document is useful only for contributors who wants improve the DevOps Dojo
coach and install their own instance.  
Student who wants to run the training can ignore this page.

This setup requires:

- an AWS user with policies allowing to create an API Gateway and Lambda
function, for example [this](./lambda-dojo-upload.json);
- a fork of [dxc-technology/online-devops-dojo](https://github.com/dxc-technology/online-devops-dojo)
repository. We will name it below `<my_account>\online-devops-dojo` where you
will substitute `<my_account>` by your GitHub account.

## Steps

1. Get credentials of your AWS user:  (**AWS_ACCESS_KEY** &
**AWS_SECRET_KEY**) from the AWS Console in IAM (Users / *Select a user* / Security Credentials / Create Access Key) and store each in a
GitHub secret of `<my_account>/online-devops-dojo`
(click repository tab Settings, then Secrets).  
1. Set AWS_STAGE & AWS_REGION in GitHub Secrets of `<my_account>/online-devops-dojo`.
   For example `dev` or `prod` & `us-east-1`.
1. Since the workflow which uploads the lambda function is triggered by a push:  
    1. Commit a small change like a space in `index.js` in the repository `<my_account>/online-devops-dojo` in master branch.
    1. Click on <svg class="octicon octicon-play" viewBox="0 0 14 16"
    version="1.1" width="14" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M14 8A7 7 0 1 1 0 8a7 7 0 0 1 14 0zm-8.223 3.482l4.599-3.066a.5.5 0 0 0 0-.832L5.777 4.518A.5.5 0 0 0 5 4.934v6.132a.5.5 0 0 0 .777.416z"></path></svg> Actions tab and verify that the workflow runs without error.
1. GitHub app creation
    1. From the AWS Console, open the lambda `devops-dojo-robot-dev-lambda`, click on API Gateway and copy the **API endpoint**.
    1. Create a new GitHub app with [this link](https://github.com/settings/apps/new?description=The%20Online%20DevOps%20Dojo%20coach%20is%20here%20to%20help%20you%20learn%20DevOps.%0A%0ALearn%20more%20about%20the%20Online%20DevOps%20Dojo%3A%20https%3A%2F%2Fraw.githubusercontent.com%2Fdxc-technology%2Fonline-devops-dojo%2Fmaster%2Fassets%2Fonline-devops-dojo%2Fleading-change%2Fteam-chat.jpg%29&contents=write&issues=write&pull_requests=write&events[]=issues&events[]=issue_comment&events[]=pull_requests) to get a prefilled form then complete it with the following steps.
    1. Set a unique **GitHub App name** of your own.
    1. Paste the **API endpoint** in both fields:
        - **User authorization callback URL**
        - **Webhook URL**
    1. Complete **Homepage URL** with the URL of `<my_account>/online-devops-dojo` repository.
    1. On a terminal, create a Webhook secret with:

       ```sh
       ruby -rsecurerandom -e 'puts SecureRandom.hex(20)'
       ```

       copy the returned string, then:

        1. Paste it in GitHub app form **Webhook secret**,
        1. Paste it a new GitHub secret named **WEBHOOK_SECRET** of
        `<my_account>/online-devops-dojo`.  
    1. The correct permissions and events have already been pre-filled.  
    1. To **Where can this GitHub App be installed?** answer **Any account**.
    1. Click **Create GitHub app**.
    1. Click on **Generate a private key** (at the bottom), save it in a file
    like `certificate.private-key.pem`.
    1. In a terminal, run the following command on the `.pem` file in order to get
    a single-line string:

       ```sh
       cat certificate.private-key.pem | base64 -w 0
       ```

    1. Copy the output string into a new `<my_account>/online-devops-dojo` secret named **PRIVATE_KEY**.
    1. On the top of the GitHub app About page, copy the **App ID** and paste it in a new  `<my_account>/online-devops-dojo` secret named **APP_ID**.
    1. Commit a minor change on `index.js` (like a space) in master branch. This will
       trigger the <svg class="octicon octicon-play" viewBox="0 0 14 16"
    version="1.1" width="14" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M14 8A7 7 0 1 1 0 8a7 7 0 0 1 14 0zm-8.223 3.482l4.599-3.066a.5.5 0 0 0 0-.832L5.777 4.518A.5.5 0 0 0 5 4.934v6.132a.5.5 0 0 0 .777.416z"></path></svg> Action
    workflow again and set the **PRIVATE_KEY** in lambda environment.

1. GitHub App installation  
   1. In GitHub app **Install app** menu, on Repository access, click **Only select
   repositories** and select your forked pet-clinic repository.
   1. Click **Install**.
   1. On the menu, click **Public page** and <ins>note its URL</ins>: this is the URL
   that must be documented in Welcome module to invite students to install the bot.

### Note

Upload action had to run twice: before and after the GitHub app creation
because the installations are mutually dependent (App requires AWS' generated
API endpoint, and AWS requires App's generated PRIVATE KEY).
