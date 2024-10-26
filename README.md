# semantic-release-bot

Alpine container that contains semantic-release and required dependencies

This container is meant to be used in a CI platform such as GitLab to run a semantic release job.

Here is a sample job configuration.

```yaml
semantic-release:
  image: ghcr.io/mmansell83/semantic-release-bot:latest
  stage: release
  variables:
    GIT_AUTHOR_EMAIL: release-bot@stolenleadsmen.com
    GIT_COMMITTER_EMAIL: release-bot@stolenleadsmen.com
    GIT_DEPTH: '0'
  before_script:
    - git config --global --add safe.directory $PWD
  script:
    - semantic-release
  rules:
    - if: $CI_PIPELINE_SOURCE == "schedule"
      when: never
    - if: $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH
```
