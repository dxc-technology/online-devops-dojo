// index.js: core coach code triggered by the DevOps Dojo coach github
// app on any event to the GitHub repositories where the GitHub app is installed.
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at http://mozilla.org/MPL/2.0/.

const coachName = 'online-devops-dojo-coach'

module.exports = app => {
  app.log('Yay! The ' + coachName + ' was run!')
  app.on(['issue_comment.created','issue_comment.edited'], async context => {
    const { github, payload } = context
    const isPR = !!payload.issue.pull_request

    const comment = payload.comment
    const user = comment.user
    const commentBody = comment.body && comment.body.toLowerCase()
    const { owner, repo, number } = context.issue()

    // Let's not do anything if the comment was made by a bot
    if (user.isBot()) {
      app.log('Skipping event triggered by bot: ' + user.login + ' (' + owner + '/' + repo + ').')
      return
    }

    // We only care about comments on pet-clinic repository
    if (repo != 'pet-clinic') {
      app.log('Skipping - not pet-clinic repository (' + owner + '/' + repo + ').')
      return
    }

    // Check if it is a PR
    if (!isPR) {
      app.log('Skipping event not related to a PR (' + owner + '/' + repo + ').')
      return
    }

    app.log('Comment on a pull request #' + number + ' in ' + owner + '/' + repo + ' repository...')

    // Count the number of existing comments from this bot in this PR.
    // Note that warning about deprecated number instead of issue_number could only be fixed with next major Probot release (10)
    // https://github.com/probot/probot/pull/926
    var issueComments = await context.github.issues.listComments({ owner, repo, number })
    var botComments = 0
    issueComments.data.forEach(function (comment) {
      if (comment.user.isBot() && comment.user.login.startsWith(coachName)) {
        botComments++
      }
    })
    app.log('Found ' + botComments + ' comment' + ((botComments > 1) ? 's' : '') + ' by the bot ' + coachName + ' in this PR.')

    function commentIgnored() {
      app.log('Comment ignored.')
    }
    function addComment(msg) {
      const issuesComment = context.issue({ body: msg })
      app.log(msg)
      return context.github.issues.createComment(issuesComment)
    }
    
    // Version control module
    if (commentBody.match(/\/\s*paulo\W.*(?:review|check|verify)/)) {
      switch (botComments) {
        case 0:
          return addComment('![Paulo](https://raw.githubusercontent.com/dxc-technology/online-devops-dojo/raw/master/assets/online-devops-dojo/version-control/santhosh.png)\n Sure! I looked at the changes, and Brenda wants us to not only have horses but also ponies. So, we need to add `pony` in addition to `horse`. Can you do that?')
        case 1:
          addComment('![Paulo](https://raw.githubusercontent.com/dxc-technology/online-devops-dojo/raw/master/assets/online-devops-dojo/version-control/santhosh.png)\n Looks good :+1: ! Merging this pull request.')
          if ( typeof context.github.pullRequests !== 'undefined' && context.github.pullRequests )
          {
            return await context.github.pullRequests.merge({ owner, repo, number })
          }
          else
          {
            app.log('context.github.pullRequests undefined #' + number + ' in ' + owner + '/' + repo + '.')
          }
          break
        default:
          commentIgnored
      }
    }
    // Continuous integration module
    else if (commentBody.match(/\/\s*tina\W.*(?:review|check|verify|look|done|finish)/)) {
      switch (botComments) {
        case 0:
          return addComment('![Tina](https://raw.githubusercontent.com/dxc-technology/online-devops-dojo/master/assets/online-devops-dojo/continuous-integration/tina.png)\n That looks good. Yet, I think we should replace `Jolly Jumper` by `Silver Blaze`. Can you make the change?')
        case 1:
          return addComment('![Tina](https://raw.githubusercontent.com/dxc-technology/online-devops-dojo/master/assets/online-devops-dojo/continuous-integration/tina.png)\n :+1: thanks!')
        default:
          commentIgnored
      }
    } else commentIgnored
  })
}
