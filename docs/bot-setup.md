# Online DevOps Dojo coach setup

This document is useful only for contributors who wants improve the DevOps Dojo
coach and install their own instance.  
Student who wants to run the training can ignore this page.

Our implementation uses a GitHub application with [Probot](https://probot.github.io/)
and upload a lambda function using [GitHub Actions](https://github.com/features/actions)
and [Serverless](https://serverless.com/).  
Other
alternatives are of course possible.

This setup requires:

- an AWS account with policies allowing to create an API Gateway and Lambda
function, for example [this](./lambda-dojo-upload.json);  
- a GitHub.com account with [GitHub Actions](https://github.com/features/actions)
 enabled (currently in beta);  
- a fork of [dxc-technology/online-devops-dojo](https://github.com/dxc-technology/online-devops-dojo)
repository. We will name it below `<my_account>\online-devops-dojo` where you
will substitute `<my_account>` by your GitHub account.  

## Steps

1. Get credentials of your AWS account (**AWS_ACCESS_KEY_ID** &
**AWS_SECRET_ACCESS_KEY**) from the AWS Console in IAM and store each in a
GitHub secret of `<my_account>/online-devops-dojo`
(click repository tab Settings, then Secrets).  
1. To trigger the upload of the lambda function:  
    1. In a new branch, copy the action workflow file `./upload_lambda.yml` into
    `./.github/workflows/`. and create a PR.
    1. Click on <svg class="octicon octicon-play" viewBox="0 0 14 16"
    version="1.1" width="14" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M14 8A7 7 0 1 1 0 8a7 7 0 0 1 14 0zm-8.223 3.482l4.599-3.066a.5.5 0 0 0 0-.832L5.777 4.518A.5.5 0 0 0 5 4.934v6.132a.5.5 0 0 0 .777.416z"></path></svg> Actions tab and ensure that the workflow runs without error.
1. GitHub app creation
    1. From the AWS Console, open the lambda `devops-dojo-robot-dev-lambda`,
    click on API Gateway and copy the **API endpoint**.
    1. Create a new GitHub app with [this link](https://github.com/settings/apps/new?description=The%20Online%20DevOps%20Dojo%20coach%20is%20here%20to%20help%20you%20learn%20DevOps.%0A!%5BTeam%20chat%5D(https%3A%2F%2Fs3.amazonaws.com%2Fdevopsdojoassets%2Fteam-chat.jpg)&contents=write&issues=write&pull_requests=write&events[]=issues&events[]=issue_comment&events[]=pull_requests)
    to get a prefilled form then complete with:
    1. Paste the **API endpoint** in both fields:
        - **User authorization callback URL**
        - **Webhook URL**
    1. Set a unique **GitHub App name** of your own.
    1. Complete **Homepage URL** with the URL of `<my_account>/online-devops-dojo`
    repository.
    1. On a terminal, create a Webhook secret with:

       ```sh
       ruby -rsecurerandom -e 'puts SecureRandom.hex(20)'
       ```

       copy the returned string, then:

        1. Paste it in GitHub app form **Webhook secret**,
        1. Paste it a GitHub secret named **WEBHOOK_SECRET** of
        `<my_account>/online-devops-dojo`.  
    1. The correct permissions and events have already been pre-filled.  
    1. Click *Create GitHub app*.
    1. Click on Generate a private key (at the bottom), save it a file
    like `certificate.private-key.pem`.
    1. In a terminal, run the following command on the .pem file in order to get
    a single-line string:

       ```sh
       cat certificate.private-key.pem | base64 -w 0
       ```

    1. Copy the string into a `<my_account>/online-devops-dojo` secret named **PRIVATE_KEY**.
    1. On the top of the GitHub app About page, copy the **App ID**.
    1. Edit `<my_account>/online-devops-dojo/.github/workflows/upload_lambda.yml`
       and paste the value in APP_ID (near the bottom). Create a PR, this will
       run the <svg class="octicon octicon-play" viewBox="0 0 14 16"
    version="1.1" width="14" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M14 8A7 7 0 1 1 0 8a7 7 0 0 1 14 0zm-8.223 3.482l4.599-3.066a.5.5 0 0 0 0-.832L5.777 4.518A.5.5 0 0 0 5 4.934v6.132a.5.5 0 0 0 .777.416z"></path></svg>
    Action workflow again and set the **PRIVATE_KEY** in lambda environment.

1. GitHub App installation  
   1. In GitHub app Install app menu, on Repository access, click *Only select
   repositories* and select your forked pet-clinic repository
   1. Click install.
   1. On the menu, click Public page and <ins>record its URL</ins>: this is the URL
   that must be documented in Welcome module to invite students to install the bot.

Note:  
Upload action had to run twice: before and after the GitHub app creation
because the installations are mutually dependent (App requires AWS' generated
API endpoint, and AWS requires App's generated PRIVATE KEY).
