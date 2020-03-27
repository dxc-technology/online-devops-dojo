## Version control: what for?

|   |   |
|---|---|
|![](../../assets/online-devops-dojo/version-control/paulo.png)|**Paulo** wants us to support veterinarians who handle horses.<br/> He documented several user stories in the backlog. They have been prioritized and are now ready to be implemented.
|![](../../assets/online-devops-dojo/version-control/dan.png)|**Dan** is ready to work on the user stories from **Paulo**.

**Previously**, Dan was not using version control. Every now and then, he has been saving his code to a directory on a file share. This quickly became a problem when more people got added to the team: it was hard to collaborate, with others overwriting changes, creating regressions which got caught late in production. Managing backups of earlier versions to keep a history of the changes was also problematic: he implemented workarounds by adding versions in the file names: `main.java`, `main-1.0.java`, `main-1.1.java` and `main-1.1.final.java`. This became unmanageable when several files had to be kept "in sync" for the application to work. Finally, the team could not easily spot what was changed between those versions, making production troubleshooting a very difficult and cumbersome activity.

**Then** Dan's team invested in a proper version control system. They picked GIT, the de facto standard version control system. GIT is a Distributed Version Control System, which makes it extremely fast as it mainly runs disconnected from the network. GIT alone did not provide all of the collaboration capabilities they needed, so they started to use GitHub which wraps GIT and provides additional collaboration capabilities.

|   |   |
|---|---|
|![](../../assets/online-devops-dojo/version-control/tina.png)|Not only is **Dan**'s team using version control daily, now **Tina** is using it to manage her automated test cases.<br/> Automated test cases are managed as code, in GIT, and executed as part of the continuous delivery pipeline.
|![](../../assets/online-devops-dojo/version-control/adam.png)|**Adam** is using GIT to manage his scripts to automate infrastructure (server, storage, network) configuration.<br/> Adding more storage amounts to adding an entry in the configuration file in GIT so that it gets peer reviewed and automatically tested before being implemented in the live environment.

The team chose a [branching model](https://www.atlassian.com/git/tutorials/comparing-workflows) which works for them: they use short lived feature branches which they often commit to the trunk (master).
