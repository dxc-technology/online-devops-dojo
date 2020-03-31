module.exports = app => {
  app.log('Yay! The DevOps Dojo coach was run!')
  app.on('issue_comment.created', async context => {
    const { github, payload } = context
    const isPR = !!payload.issue.pull_request
    const isIssue = !!payload.issue.pull_request

    const comment = payload.comment
    const user = comment.user
    const commentBody = comment.body && comment.body.toLowerCase()
    const userName = user.login
    const isBot = user.type === 'Bot'  // for a genuine user this 'User'
    const {owner, repo, number} = context.issue()
  
    // Let's not make anything if comment was made by a bot
    if (isBot) {
      return
    }

    // We only care about comments on pet-clinic repository
    if (repo != 'pet-clinic') {
      app.log('Skipping - not pet-clinic repository.')
      return
    }

    // Check if it is a PR
    if (!isPR) {
      return
    }
    app.log('This is a comment on a pull request ' + number + ' in ' + owner + '/' + repo + ' repository...')

    // Note that GitHub usernames paulo and tina seem reserved by people who have never used their account for 3 and 10 years.

    // Version control module
    if (commentBody.match(/@paulo\s.*(?:review|check|verify)/)){

      switch (countBotComments('paulo')) {
        case 0:
          issuesComment = context.issue({ body: '![Paulo](https://s3.amazonaws.com/devopsdojoassets/paulo.png)\n Sure! I looked at the changes, and Brenda wants us to not only have horses but also ponies. So, we need to add `pony` in addition to `horse`. Can you do that?' })
          ret = context.github.issues.createComment(issuesComment) 
          break;
        case 1:
          issuesComment = context.issue({ body: '![Paulo](https://s3.amazonaws.com/devopsdojoassets/paulo.png)\n Looks good :+1: ! Merging this pull request.' })
          ret = context.github.issues.createComment(issuesComment) 
          ret = context.github.pullRequests.merge({ owner, repo, number });
          break;
      }
      return ret // Return the last result. Not very accurate, but will do.
    } 
    // Continuous integration module
    else if (commentBody.match(/@tina\s.*(?:review|check|verify|look|done|finish)/)){
      switch (countBotComments('tina')) {
        case 0:
          issuesComment = context.issue({ body: '![Tina](https://s3.amazonaws.com/devopsdojoassets/tina.png)\n That looks good. Yet, I think we should replace `Jolly Jumper` by `Silver Blaze`. Can you make the change?' })
          ret = context.github.issues.createComment(issuesComment)
          break;
        case 1:
          issuesComment = context.issue({ body: '![Tina](https://s3.amazonaws.com/devopsdojoassets/tina.png)\n :+1: thanks!' })
          ret = context.github.issues.createComment(issuesComment)
          break;
      }
      return ret // Return the last result. Not very accurate, but will do.
    }
  })
}

// Get the list of comments for the bot named botName
function countBotComments(botName) {
  // Note that warning about deprecated number instead of issue_number could only be fixed with next major Probot release (10)
  // https://github.com/probot/probot/pull/926
  const issueComments = context.github.issues.listComments({owner, repo, number})
  botComments = 0
  issueComments.data.forEach(function(comment) {
    if (comment.user.type == 'Bot') {
      botComments++
      app.log('botName:'+ botName) // comment.user.login)
    }
  })
  app.log('Found ' + botComments + ' comments by the bot in this PR')
  return botComments
}