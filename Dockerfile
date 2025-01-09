FROM docker.io/library/node:22.13.0-alpine@sha256:bbe9b971cb51593d8a4b8aa81ab031f2b3f3a6344d4fb297335a5fb058ad8c46

# renovate: datasource=npm depName=semantic-release
ENV SEM_REL_VER="24.2.1"
# renovate: datasource=npm depName=conventional-changelog-conventionalcommits
ENV CCCC_VER="8.0.0"
# renovate: datasource=npm depName=@semantic-release/gitlab
ENV SEM_REL_GITLAB_VER="13.2.3"

RUN apk update && apk upgrade && \
    apk add git && \
    apk cache clean

WORKDIR /semantic-release-bot

RUN npm install -g semantic-release@${SEM_REL_VER} \
    @semantic-release/gitlab@${SEM_REL_GITLAB_VER} \
    conventional-changelog-conventionalcommits@${CCCC_VER}
