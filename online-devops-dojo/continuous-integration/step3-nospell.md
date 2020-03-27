As Dan the developer

![](../../assets/online-devops-dojo/continuous-integration/dan.png)

 you are working on the user story which was prioritized by Paulo, the product
 owner.

![](../../assets/online-devops-dojo/continuous-integration/paulo.png)

![](../../assets/online-devops-dojo/continuous-integration/user-story.png)

The user story is visible as a GitHub issue in your GitHub repo:
[https://github.com/[your_username]/pet-clinic/issues](https://[[HOST_SUBDOMAIN]]-9876-[[KATACODA_HOST]].environments.katacoda.com/#user-story)

In the context of that user story which we started earlier, we need to add
entries in the Pet Clinic database to add new pet names.

# Add new pet names in the database

You are about to modify the Pet Clinic code. In the Version Control module, we
used the git client in the terminal window. In this module, you will use another
method, through GitHub's web interface.

* Head over to your copy of the Pet Clinic application on GitHub, and navigate
  to the file in the
  [`src/main/resources/db/hsqldb`](https://[[HOST_SUBDOMAIN]]-9876-[[KATACODA_HOST]].environments.katacoda.com/#datasql)
  folder named `data.sql`. This file is used to populate the application
  database with data when the pet clinic application is started
* Click on the pencil icon in the top right corner to edit the file
* Below `INSERT INTO pets VALUES (13, 'Sly', '2012-06-08', 1, 10);` around line 51, add two new lines for individual horses:
  <pre class="file" data-target="clipboard">

  INSERT INTO pets VALUES (14, 'Jolly Jumper', '2012-09-20', 7, 5;
  INSERT INTO pets VALUES (15, 'Flycka', '2012-07-14', 7, 9);
  </pre>
* Do not save or commit your changes yet!

**NOTE**: Yes, there is an error on the "Jolly Jumper" line - well done if you
catch it! This is on purpose, so that you can see the checks which are
automatically performed during continuous integration.
