At this point, because you have fixed the only open issue all the automated checks will have passed.

It is now time to involve someone else for a peer review.

## Tasks

![](../../assets/online-devops-dojo/continuous-integration/tina.png)

* In the pull request, add a comment to ask Tina the tester to review the pull request: `/tina - can you have a look at this?`{{copy}}
* After checking the changes in the "Files changed" tab, Tina will have comments, and wants you to replace "Jolly Jumper" by "Silver Blaze", around line 51.
* Go ahead and implement the change by clicking the pen icon in the "Files changed" tab next to `data.sql` file, in the context of the existing - still opened - pull request.
* Jenkins will again build and test the entire application with this latest change, making sure everything builds and tests are passing. Check it at: <a href="https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/blue/organizations/jenkins/pet-clinic/pr" target="jenkins">https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/blue/organizations/jenkins/pet-clinic/pr</a>
* If everything is OK, the tests will pass. The pull request displays the checks done by Jenkins: everything is green!
