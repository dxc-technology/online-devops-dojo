# Online DevOps Dojo  [![License: MPL 2.0](https://img.shields.io/badge/License-MPL%202.0-brightgreen.svg)](https://opensource.org/licenses/MPL-2.0)

[![Javascript linter](../../workflows/Javascript%20linter/badge.svg)](../../actions?query=workflow%3A%22Javascript+linter%22)
[![Check links in markdown](../../workflows/Check%20links%20in%20markdown/badge.svg)](../../actions?query=workflow%3A%22Check+links+in+markdown%22)
[![Deployment of Online DevOps Dojo coach lambda](../../workflows/Deployment%20of%20Online%20DevOps%20Dojo%20coach%20lambda/badge.svg)](../../actions?query=workflow%3A%22Deployment+of+Online+DevOps+Dojo+coach+lambda%22)

This repository contains the sources of the **[Online DevOps Dojo](https://dxc-technology.github.io/about-devops-dojo/)**
Katacoda Scenarios and the coach robot.

If you are landing here and just want to get going with the training, please
go to [about the DevOps Dojo](https://dxc-technology.github.io/about-devops-dojo/).

## Changelog

See a [history of the changes](CHANGELOG.md) to the **Online DevOps Dojo**.

## Files description

### Training scenarios

The scenarios run on the [Katacoda](https://www.katacoda.com/) interactive learning and training platform.

- [`online-devops-dojo-pathway.json`](online-devops-dojo-pathway.json): Index of
Katacoda scenarios
- [`online-devops-dojo/`](online-devops-dojo/): Katacoda scenarios: one sub-folder
for each training
- [`assets/online-devops-dojo/`](assets/online-devops-dojo/): Images used in
training pages

### Dojo coach

- [`docs/`](docs): Documentation about the coach bot
- [`handler.js`](handler.js): Handler for the Lambda function
- [`index.js`](index.js): Coach code
- [`package.json`](package.json): Node package dependencies
- [`package-lock.json`](package-lock.json): Tested set of Node module dependencies

### CI/CD

- [`serverless.yml`](serverless.yml): Serverless deployment configuration file  
  I have not found a way to isolate the coach files in a sub-folder and execute
  Serverless there. Help is welcome.

In [`.github/workflows`](.github/workflows/) folder:

- [`md-links.yml`](.github/workflows/katacoda.yml):
  Validate Katacoda scenarios.
- [`upload_lambda.yml`](.github/workflows/upload_lambda.yml):
  GitHub workflow triggered on repository pushes, which uploads the coach lambda function to AWS.
- [`upload_lambda_from_comment.yml`](.github/workflows/upload_lambda_from_comment.yml):
  Same upload as above but triggered by a comment `/deploy` (was convenient when manual trigger wasn't possible).
- [`linters.yml`](.github/workflows/linters.yml):
  Javascript linter (configuration in [`/.eslintrc.json`](.eslintrc.json)).
- [`md-links.yml`](.github/workflows/md-links.yml):
  Validate links in MarkDown files.

## Contributing

If you want to contribute to the DevOps trainings, see [the contribution instructions](CONTRIBUTING.md).

If you are interested in the coach, please read its [setup process](docs/bot-setup.md).

## Issues

If you experience some problems with the existing scenarios, please open an
[issue](https://github.com/dxc-technology/online-devops-dojo/issues/new/choose)
and let us know.

## License

This project is licensed under the Mozilla Public License Version 2.0 - see
the [LICENSE](LICENSE) file for details.
