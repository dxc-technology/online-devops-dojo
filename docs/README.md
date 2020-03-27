# Online DevOps Dojo coach ![](../../../workflows/Deployment%20of%20Online%20DevOps%20Dojo%20coach%20lambda/badge.svg)

The Online DevOps Dojo coach is here to make the DevOps learning experience
even more enjoyable.

Actually the coach is a robot which allows you to interact with the "Charlie
Veterinary Clinic" virtual team in the context of GitHub issues and pull requests.

One can imagine a lot of funny exchanges which at some point will require a
genuine test pipeline!

![Team chat](https://s3.amazonaws.com/devopsdojoassets/team-chat.jpg)

## Setup

How to [Setup](./bot-setup.md) your custom instance of the robot.

## High level architecture

Our implementation uses a GitHub application with [Probot](https://probot.github.io/)
and upload an AWS Lambda function using [GitHub Actions](https://github.com/features/actions)
and [Serverless](https://serverless.com/).  
Other alternatives would of course be possible.

![Architecture diagram](online-devops-dojo-bot.svg)

## Contributing

If you have suggestions for how the Dojo coach could be improved, or want to
report a bug, open an issue! We'd love all and any contributions.

## Roadmap

We are interested in adding the following features in the near future:

- Replace the GitHub app / Lambda function by a GitHub action.
- Make the bot more robust / versatile.
