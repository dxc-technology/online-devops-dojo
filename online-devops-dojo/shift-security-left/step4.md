⏳📅 A week has passed...

![Selma](../../assets/online-devops-dojo/shift-security-left/selma.png)

> Now that the fire drill is over, we need to take advantage of this incident (some call it an "unplanned investment opportunity") to invest and include security early in our cycle.
> Between Static Application Security Testing (SAST) and Dynamic Application Security Testing (DAST), I suggest we start with SAST and include this activity in our Continuous Integration pipeline.

![Tina](../../assets/online-devops-dojo/shift-security-left/tina.png)

> One of my concerns is all the dependencies our code relies on. Not that we can nor want to get rid of them, but we need to get this under control. Vulnerabilities are found everyday. Checking that our dependencies don't become vulnerable over time is going to be key to protect the personal data of our customers.

![Chun](../../assets/online-devops-dojo/shift-security-left/chun.png)

> The Continuous Integration Pipeline is the perfect place to add quality gates such as SAST. There are many tools we can use - including Open Source ones - such as the [OWASP dependency check](https://owasp.org/www-project-dependency-check/).
> We want this gate to run not only when we introduce changes in the code, but also on a regular basis - for example daily. This way, when (**not if**) a vulnerability is discovered in one of our dependency, our CI pipeline will detect it and notify us so that we can take action.

![Selma](../../assets/online-devops-dojo/shift-security-left/selma.png)

> I know OWASP (Open Web Application Security Project)! This is a not-for-profit charitable organization, and it can be trusted. Including this dependency checker in the pipeline is a great idea! I will sleep better at night 💤🌛 knowing that we are reducing our attack surface on that front by including security in our CI pipeline, in other words by shifting security left towards the original cause of the vulnerability.
