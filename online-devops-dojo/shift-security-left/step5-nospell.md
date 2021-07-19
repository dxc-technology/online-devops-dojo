![Dan](../../assets/online-devops-dojo/shift-security-left/dan.png)

> As Pet Clinic is a Java project, we can easily add the [OWASP dependency check](https://owasp.org/www-project-dependency-check/) as part of our pipeline, in our `pom.xml` file, as a Maven plugin. Let's do this!

## Steps

* Navigate to your GitHub copy of the Pet Clinic application to find [`pom.xml`](https://[[HOST_SUBDOMAIN]]-9876-[[KATACODA_HOST]].environments.katacoda.com/#pomfile) in the master branch.
* Click on the pencil icon in the top right corner to edit the file.
* Add the OWASP dependency checker as one of the plugins, around line 306 (after `</plugin>` without s):

<pre class="file" data-target="clipboard">
             &lt;plugin&gt;
                &lt;groupId&gt;org.owasp&lt;/groupId&gt;
                &lt;artifactId&gt;dependency-check-maven&lt;/artifactId&gt;
                &lt;version&gt;6.2.2&lt;/version&gt;
                &lt;configuration&gt;
                    &lt;format&gt;ALL&lt;/format&gt;
                    &lt;failBuildOnCVSS&gt;7&lt;/failBuildOnCVSS&gt;
                    &lt;cveValidForHours&gt;168&lt;/cveValidForHours&gt;
                &lt;/configuration&gt;
                &lt;executions&gt;
                    &lt;execution&gt;
                        &lt;goals&gt;
                            &lt;goal&gt;check&lt;/goal&gt;
                        &lt;/goals&gt;
                    &lt;/execution&gt;
                &lt;/executions&gt;
            &lt;/plugin&gt;
</pre>

* 💡 Note that we fail the build if CVSS is >= 7. It all depends of the context
  of your project and where you want to put the bar. More information on CVSS at
  [https://www.first.org/cvss/v3.1/user-guide](https://www.first.org/cvss/v3.1/user-guide).
* Create a pull request by committing the changes in a new branch which you will
  name: `deps-check`{{copy}}
* The build will trigger automatically.
* Navigate to <a href="https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/blue/organizations/jenkins/pet-clinic/activity" target="jenkins">Jenkins</a> to see the results of the build.
* Be patient. The build will succeed: at this time, we are missing the step in the pipeline
  (Jenkinsfile) to actually check for dependencies. The plugin is in the
  `pom.xml` file but is not used yet.
