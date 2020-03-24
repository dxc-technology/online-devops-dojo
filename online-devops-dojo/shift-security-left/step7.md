![Selma](../../assets/online-devops-dojo/shift-security-left/selma.png)

> According to the OWASP scan, at least the `tomcat-embed-core-9.0.29.jar` dependency has a critical vulnerability ([CVSS>7](https://www.cvedetails.com/)).
> I'm glad we find this now before it gets exploited!

![Hal](../../assets/online-devops-dojo/shift-security-left/hal.png)

> That's right, even if the application you build is secure, you have to watch the entire ecosystem, continuously.
> The custom code you build is harder for me to penetrate because it's... custom.
> But, the operating system, libraries, and all the other dependencies that the application relies upon are an easier target for me:
> I can find information on the internet to exploit newly discovered vulnerabilities.

![Dan](../../assets/online-devops-dojo/shift-security-left/dan.png)

> The `tomcat-embed-core-9.0.29.jar` dependency is in the `pom.xml` file.
> I remember we had to "pin" (stick to) this version previously, but we fixed the issue some time back.
> Let's update to the latest version.

## Steps

* Go to <https://mvnrepository.com/> to find a new version number of that
  library. Using the smallest minor revision is always preferred to not
  destabilize the code. That said, automated tests provide a good safety.
* Navigate to your copy of the Pet Clinic application to find
  [`pom.xml`](https://[[HOST_SUBDOMAIN]]-9876-[[KATACODA_HOST]].environments.katacoda.com/#pomfilebranch),
  in the same `deps-check` branch from the pull request.
* Click on the pencil icon in the top right corner to edit the file.
* Locate the `tomcat-embed-core` dependency, and update the version number in
  the line below with `<version>`. Make the same update on
  `tomcat-embed-websocket`, you will save time.
* Commit the change in this `deps-check` branch, in the context of the pull
  request.
* The build will trigger automatically.
* Navigate to <a href="https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/blue/organizations/jenkins/pet-clinic/activity" target="jenkins">Jenkins</a>
  to see the results of the build.
* This time, the OWASP check should come out with no error: everything good! ✔

---
## The pipeline still fails?

![Selma](../../assets/online-devops-dojo/shift-security-left/selma.png)

> As Hal said, new vulnerabilities are found all the time. It can be that a
> new vulnerability has been found since we last updated the Pet Clinic
> application. It may be difficult to find which dependency to update in the `pom.xml` file
> if it is a dependency of a dependency that is vulnerable.

At this point you have resolved the vulnerability we wanted you to resolve. If
there are new additional vulnerabilities identified you either:

* fix them using the process which follows,
* or you can ignore any additional items and proceed with the rest of the module.
  It can happen that new vulnerabilities are discovered but no fix exists yet.
  Our pipeline would require some enhancements to assess the risk and continue,
  but this exceed the scope of this training. If you are blocked, just raise the
  maximum CVSS score (failBuildOnCVSS in `pom.xml`; maximum is 10), so that you
  can proceed with the next step.

## Fix other vulnerabilities

You will need to walk the dependency tree. Let's first go to the correct branch
in the repository:

* Go to the terminal window
  ```
  cd ~/pet-clinic
  git pull
  git checkout deps-check
  ```{{execute}}

Now let's look at the dependency tree:

* `mvn dependency:tree`{{execute}}
  (or `mvn dependency:tree | egrep --color=auto 'my-vulnerable-dep|$'` to highlight
  "`my-vulnerable-dep`" without version number)
* Look for the dependency that has been identified as vulnerable in the OWASP
  dependency check report.
* Walk up the tree and find the library which includes the vulnerable
  dependency. In this example, `databind` is vulnerable:
  ![](../../assets/online-devops-dojo/shift-security-left/mvn-tree.png)
* In this example, you need to locate `spring-boot-actuator-autoconfigure` in
  `pom.xml` or update an higher level dependency.
* Go to <https://mvnrepository.com/> to find a new version of that library.
* Update the `pom.xml` file with the new version - `nano pom.xml`{{execute}}
* Push the updated version:
  ```
  git add pom.xml
  git commit -m "Fix dependency"
  git push
  ```{{execute}}
* Check the execution of the pipeline and the results.
* Repeat until dependency check is green.

Note that a training session lasts one hour maximum. Beyond, since your repository is saved in GitHub, you will just need to restart the module (F5) and fast forward.
