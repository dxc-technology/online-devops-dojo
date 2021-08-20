# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.6.1] - 2021-08-20

### Fixed

- Error running prepare.sh in version control module

## [1.6.0] - 2020-12-15

### Added

- Post Incident Practices Module

## [1.5.1] - 2020-12-13

### Changed

- Introduced Dojo Octocat in Welcome module

## [1.5.0] - 2020-10-21

### Changed

- Bump serverless to v2.1.
- Run the link checker every 3 days only.

## [1.4.1] - 2020-10-11

### Fixed

- Updated estimated times for VSM and Kaizen modules

## [1.4.0] - 2020-10-09

### Changed

- Add Javascript linter.
- Upgrade GitHub Actions virtual environment to Ubuntu LTS 20.04.
- Bump markdown link checker.
- Markdown link checker ignore HTTP 429 Too Many Requests.
- Trigger the markdown link checker on commit on markdown files and linter only.
- Bump NPM dependencies.
- Add workflow badges.

## [1.3.0] - 2020-10-05

### Added

- Value Stream Mapping and DevOps Kaizen modules.
- Upgrade GitHub Actions virtual environment to Ubuntu LTS 20.04.

## [1.2.1] - 2020-06-26

### Fixed

- Bump Node.js dependencies.
- GitHub app prefilled URL form using local team-chat.jpg.

## [1.2.0] - 2020-05-06

### Changed

- Improve coach logging.
- Use repository images for bot comments and notifications.

### Fixed

- Dojo coach wasn't able to merge PR.

## [1.1.0] - 2020-04-08

### Added

- Trigger the lambda upload from a comment.
- Approval workflow.

### Changed

- Use / instead of @ to invoke the coach.
- Add Node.js caching step in lambda upload workflow.
- Add APP_ID secret and rename AWS secrets.

### Fixed

- Cleanup of previous webhooks.
- Update OWASP links.

## [1.0.2] - 2020-03-27

- Version control: update a few line numbers, fine tune instructions.
- Add stale action.

## [1.0.1] - 2020-03-20

### Changed

- Update Shift Left on Security module with updated dependencies of Pet Clinic.
- Bump NPM dependencies
- Replace Katacoda internal tab for Jenkins with a browser tab (workaround for Chrome sameSite cookie issue).

## [1.0.0] - 2019-07-16

### Added

- Initial version
