
The output of the DevOps Kaizen events are the Improvement Themes.

![](../../assets/online-devops-dojo/devops-kaizen/tina.png)

Tina and the team came up with the following testing improvement theme:

## **Title**: Continuous Testing

| ![](../../assets/online-devops-dojo/devops-kaizen/current-state.png) **Now/Problem**  |  ![](../../assets/online-devops-dojo/devops-kaizen/target.png) **Next Target Condition**  |
|---|---|
| Testing is mostly manual, mainly performed after the development is completed, feedback on issues is too late in the process which in turn is leading to rework and delays | Introduce functional tests with Selenium and execute the tests from our CI pipeline |
| ![](../../assets/online-devops-dojo/devops-kaizen/awesome.png) **Definition of Awesome**  | ![](../../assets/online-devops-dojo/devops-kaizen/steps.png) **First Steps** |
| Any code committed to our source code management system would be continuously integrated via a Jenkins pipeline. <br/>The pipeline would execute of a comprehensive set of automated tests (continuous testing) against the code.<br/>These tests would include unit tests that cover 70 to 80% of the code and automated acceptance tests of key functional areas. | Add a stage in our pipeline which includes automated functional tests.  |

![](../../assets/online-devops-dojo/devops-kaizen/santhosh.png)

Santhosh, as a good Scrum master, wants to have all the work prioritized in the
agile backlog. So, let's add that improvement theme in our backlog:

 `./add.improvement.to.backlog.sh`{{execute}}

**Note**: you will re-use GitHub's "Personal Access Token" you created in the
Welcome module. If you need to generate a new one, go to
[https://github.com/settings/tokens](https://github.com/settings/tokens)
and save it for later.

💡 **TIP**: 🦊 Firefox user? Use <kbd>CTRL</kbd>+<kbd>INS</kbd> /
<kbd>SHIFT</kbd>+<kbd>INS</kbd> to copy/paste your Personal Access Token in the
window.
