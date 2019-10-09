module.exports = (app) => {
  app.log('Yay! The app was loaded!')
  app.on('issue_comment.created', async context => {
    const { github, payload } = context
    const isPR = !!payload.issue.pull_request
    const comment = payload.comment
    const user = comment.user
    const commentBody = comment.body && comment.body.toLowerCase()
    const userName = user.login
    const isBot = user.type === 'Bot'
    const {owner, repo, number} = context.issue()
  

    // Let's not make anything if it is our Bot
    if (isBot) {
      return
    }

    // We only want this on pet-clinic repository
    if (repo != 'pet-clinic') {
      app.log('Skipping - not pet-clinic repo')
      return
    }

    // Check if it is a PR
    if (!isPR) {
      return
    }
    app.log('This is a comment on a pull request ' + number + ' in ' + owner + '/' + repo + ' repo...')

    // Get the list of comments in this PR
    // Note that warning about deprecated number instead of issue_number is a wrong warning https://github.com/probot/probot/pull/926
    const issueComments = await context.github.issues.listComments({owner, repo, number})
    botComments = 0
    issueComments.data.forEach(function(comment) {
      if (comment.user.type == 'Bot') {
        botComments++
      }
    })
    app.log('Found ' + botComments + ' comments by the bot in this PR')

    if (commentBody.match(/@paulo(.*)[review|check|verify](.*)?/)){
      switch (botComments) {
        case 0:
          issuesComment = context.issue({ body: '![Paulo](https://s3.amazonaws.com/devopsdojoassets/paulo.png)\n Sure! I looked at the changes, and Brenda wants us to not only have horses but also ponies. So, we need to add `pony` in addition to `horse`. Can you do that?' })
          ret = context.github.issues.createComment(issuesComment) 
          break;
        case 1:
          issuesComment = context.issue({ body: '![Paulo](https://s3.amazonaws.com/devopsdojoassets/paulo.png)\n Looks good :+1: ! Merging this pull request.' })
          ret = context.github.issues.createComment(issuesComment) 
          ret = await context.github.pullRequests.merge({ owner, repo, number });
          break;
      }
      return ret // Return the last result. Not very accurate, but will do.
    } else if (commentBody.match(/@tina(.*)[review|check|verify|look|done|finish](.*)?/)){
      switch (botComments) {
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
    } else if (commentBody.match(/@brenda(.*)[review|check|verify|look|done|finish](.*)?/)){
      switch (botComments) {
        case 0:
          issuesComment = context.issue({ body: '![Brenda](https://s3.amazonaws.com/devopsdojoassets/brenda.png)\n Excellent! This is exactly what I was looking for. Going ahead and merging the changes.' })
          ret = context.github.issues.createComment(issuesComment)
          ret = await context.github.pullRequests.merge({ owner, repo, number });
          break;
      }
      return ret // Return the last result. Not very accurate, but will do.
    }
  })
}
 

