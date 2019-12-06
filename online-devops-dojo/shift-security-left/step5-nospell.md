![Dan](/online-devops-dojo/assets/online-devops-dojo/shift-security-left/dan.png)

> As Pet Clinic is a Java project, we can easily add the [OWASP dependency check](https://www.owasp.org/index.php/OWASP_Dependency_Check) as part of our pipeline, in our `pom.xml` file, as a Maven plugin. Let's do this!

## Steps

* Navigate to your GitHub copy of the pet clinic application to find [`pom.xml`](https://[[HOST_SUBDOMAIN]]-9876-[[KATACODA_HOST]].environments.katacoda.com/#pomfile).
* Click on the pencil icon in the top right corner to edit the file.
* Add the OWASP dependency checker as one of the plugins, at the beginning of line 208 (before `</plugins>`):

<pre class="file" data-target="clipboard">
             &lt;plugin&gt;
                &lt;groupId&gt;org.owasp&lt;/groupId&gt;
                &lt;artifactId&gt;dependency-check-maven&lt;/artifactId&gt;
                &lt;version&gt;5.2.4&lt;/version&gt;
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

* 💡 Note that we fail the build if CVSS is >= 7. It all depends of the context of your project and where you want to put the bar. More information on CVSS at [https://www.first.org/cvss/v2/guide](https://www.first.org/cvss/v2/guide).
* Create a pull request by committing the changes in a new branch which you will name: `deps-check`{{copy}}
* The build will trigger automatically.
* Navigate to [Jenkins](https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/blue/organizations/jenkins/pet-clinic/activity) to see the results of the build.
* The build will succeed: at this time, we are missing the step in the pipeline (Jenkinsfile) to actually check for dependencies. The plugin is in the `pom` file but is not used.
