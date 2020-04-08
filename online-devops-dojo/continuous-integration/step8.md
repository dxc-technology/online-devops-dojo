It is time to involve Tina again, as build and automated tests are passing:

* Ask Tina to have another look by adding a comment in the pull request:
  `/tina - done.`{{copy}}
* Tina will review and comment positively on the changes.
* Merge the pull request by clicking the "Merge pull request" button.
* Delete the branch `us-1-horse-db`.

Now that you have merged the pull request, the new code is merged to the
`master` branch, making it usable by the rest of the team.

You can see the history of the changes at [https://github.com/[your_username]/pet-clinic/commits/master](https://[[HOST_SUBDOMAIN]]-9876-[[KATACODA_HOST]].environments.katacoda.com/#commits)

* Check the pet clinic app, which has been automatically deployed by Jenkins:
  [pet-clinic app](https://[[HOST_SUBDOMAIN]]-9966-[[KATACODA_HOST]].environments.katacoda.com/)
* Click the "Find Owners" tab, leave "last name" field blank and click "Find
  owner" button.
* Check that you can find owners with the horses you added in the database.
* Select an owner, and click "Add New Pet".
* Check that you can add find "horse" and "pony" in the "Type" drop down list.
* Feel free to explore more and modify the code at will, to see Continuous
  Integration being kicked off automatically, for every code commit.

## Conclusion

You have integrated ("continuous integration") your own code with the rest of
the code base.

While you were fixing issues you introduced and had a discussion with Tina, none
of your changes impacted the rest of the team, although they were visible for
anyone in the team to review.
