## Tasks

The pipeline found an error which we need to fix. We are going to add new changes (commits) in the existing pull request to fix the error.

* Open GitHub pull requests in your repository: [https://github.com/[your_username]/pet-clinic/pulls](https://[[HOST_SUBDOMAIN]]-9876-[[KATACODA_HOST]].environments.katacoda.com/#pr)
* Open the pull request you have in progress.
* In "Files changed" tab, click on ... right to  `data.sql` file, then Edit file.
* Around line 51, replace the "Jolly Jumper" line with the following line: `INSERT INTO pets VALUES (14, 'Jolly Jumper', '2012-09-20', 7, 5);`{{copy}}
* In the "Commit changes" summary, enter a comment such as `Fix parenthesis`{{copy}}
* Commit the code, into the same branch (for example `us-1-horse-db`).

At this point, the Jenkins pipeline will be triggered again. It will again
compile the code, run the automated tests and give the pass/fail verdict within
the pull request.

* Go to <a href="https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/blue/organizations/jenkins/pet-clinic/" target="jenkins">Jenkins</a> to see the continuous integration pipeline execution.
