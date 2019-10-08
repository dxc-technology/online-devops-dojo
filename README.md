# Online DevOps Dojo [![License: MPL 2.0](https://img.shields.io/badge/License-MPL%202.0-brightgreen.svg)](https://opensource.org/licenses/MPL-2.0)

This repository contains the source of **Online DevOps Dojo** [Katacoda Scenarios](./online-devops-dojo),
[index](./online-devops-dojo-pathway.json) and the source of the [coach](./bot).

In case you are landing here in first place or want to run the trainings, please
read first [about DevOps Dojo](https://dxc-technology.github.io/about-devops-dojo/).

## Changelog

You should find [here](./CHANGELOG.md) the history of changes.

## Files

### Training scenarios

- [/online-devops-dojo-pathway.json](./online-devops-dojo-pathway.json) Index of
Katacoda scenarios
- [/online-devops-dojo/](./online-devops-dojo/) Katacoda scenarios: one sub-folder
for each training.
- [/assets/online-devops-dojo/](./assets/online-devops-dojo/) Images used in
training pages.

### Dojo coach

- [/handler.js](./handler.js) Handler for the lambda function
- [/index.js](./index.js) Coach code
- [/package.json](./package.json) Node package dependencies
- [/package-lock.json](./package-lock.json) Tested set of Node module dependencies

Unfortunately I have not found a way to move the coach files in a sub-folder.

## Contributing

The instructions are available just [here](./CONTRIBUTING.md).

## Issues

If you experience some problems with the existing scenarios, please open an
[issue](https://github.com/dxc-technology/online-devops-dojo/issues/new/choose)
and let us know.

## License

This project is licensed under the Mozilla Public License Version 2.0 - see
the [LICENSE](./LICENSE) file for details.
