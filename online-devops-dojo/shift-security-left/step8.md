![Hal](/online-devops-dojo/assets/online-devops-dojo/shift-security-left/hal.png)

> Dang! You make my job really hard now! That's OK though, I continuously monitor for new vulnerabilities.
> This is a waiting game at this point.  

![Selma](/online-devops-dojo/assets/online-devops-dojo/shift-security-left/selma.png)

> Now that we have our dependency scanner in place, how can we continuously scan for new vulnerabilities to defeat the hackers?

![Dan](/online-devops-dojo/assets/online-devops-dojo/shift-security-left/dan.png)

> The pipeline is perfect for that. Let's update the `Jenkinsfile` to trigger daily, even if there are no new code changes.

## Steps

* Navigate to your copy of the pet clinic application to find  [`Jenkinsfile`](https://[[HOST_SUBDOMAIN]]-9876-[[KATACODA_HOST]].environments.katacoda.com/#jenkinsfile), in the same `deps-check` branch from the pull request.
* Click on the pencil icon in the top right corner to edit the file.
* Below `agent any` in the `Jenkinsfile`, add a scheduled trigger: 

<pre class="file" data-target="clipboard">

    // Scan will run everyday on master
    triggers { cron( '@daily' ) }

</pre>

* Commit the change in this `deps-check` branch, in the context of the pull request.
* The build will trigger automatically.
* Navigate to [Jenkins](https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/blue/organizations/jenkins/pet-clinic/activity) to see the results of the build.
* The build should still succeed. In addition, it is also now scheduled for daily execution.
* Everything looks good: merge the pull request.
