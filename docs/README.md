# Online DevOps Dojo coach ![](../../../workflows/Deployment%20of%20Online%20DevOps%20Dojo%20coach%20lambda/badge.svg)

The Online DevOps Dojo coach is here to make the DevOps learning experience
even more enjoyable.

Actually the coach is a robot which allows you to interact with the "Charlie
Veterinary Clinic" virtual team in the context of GitHub issues and pull requests.

One can imagine a lot of funny exchanges which at some point will require a
genuine test pipeline!

![Team chat](https://raw.githubusercontent.com/pberthonneau/online-devops-dojo/master/assets/online-devops-dojo/leading-change/team-chat.jpg)

## Setup

How to [Setup](./bot-setup.md) your custom instance of the robot.

## High level architecture

Our implementation uses a GitHub application with [Probot](https://probot.github.io/)
and upload an AWS Lambda function using [GitHub Actions](https://github.com/features/actions)
and [Serverless](https://serverless.com/).  
Other alternatives would of course be possible.

![Architecture diagram](online-devops-dojo-bot.svg)

## Developing

DevOps Dojo Coach is a [GitHub App](https://developer.github.com/apps/about-apps/) built with [Probot](https://probot.github.io/) framework on Node.js. Its embedded [logging](https://probot.github.io/docs/logging/) API is [bunyan](https://github.com/trentm/node-bunyan).  

The custom bot code is fully contained in the file index.js.

The bot can be run locally with:

```sh
# Install dependencies
npm install

# Run the bot
npm start
```

More knowledge on building GitHub apps [here](https://developer.github.com/apps/building-your-first-github-app/).

## Contributing

If you have suggestions for how the Dojo coach could be improved, or want to
report a bug, open an [issue](https://github.com/dxc-technology/online-devops-dojo/issues/new/choose) or a PR! We'd love all and any contributions.

## Roadmap

We are interested in adding the following features in the near future:

- Replace the GitHub app / Lambda function by a GitHub action.
- Make the bot more robust / versatile.
