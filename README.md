# semantic-release-bot

Alpine container that contains semantic-release and required dependencies

This container is meant to be used in a CI platform such as GitLab to run a semantic release job.

Here is a sample job configuration.

```yaml
semantic-release:
  image: ghcr.io/mmansell83/semantic-release-bot:latest
  stage: release
  variables:
    GIT_AUTHOR_EMAIL: release-bot@example.com
    GIT_COMMITTER_EMAIL: release-bot@example.com
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

## Testing

`test/smoke.sh` creates a throwaway git repository with a local remote and runs `semantic-release --dry-run` with the `conventionalcommits` preset. It needs no network access or tokens. CI runs it against every build before anything is pushed.

```sh
docker build -t semantic-release-bot:test .
docker run --rm -v "$PWD/test:/test:ro" semantic-release-bot:test /test/smoke.sh
```

CI also scans the image with Trivy. Results appear in the job summary and under **Security > Code scanning**.
