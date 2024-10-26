FROM docker.io/library/node:23.1.0-alpine@sha256:1467ea23cce893347696b155b9e00e7f0ac7d21555eb6f27236f1328212e045e

# renovate: datasource=node depName=semantic-release
ENV SEM_REL_VER "24.2.0"
# renovate: datasource=node depName=conventional-changelog-conventionalcommits
ENV CCCC_VER "8.0.0"
# renovate: datasource=node depName=@semantic-release/gitlab
ENV SEM_REL_GITLAB_VER "13.2.1"

RUN apk update && apk upgrade && \
    apk add git && \
    apk cache clean

WORKDIR /semantic-release-bot

RUN npm install -g semantic-release@${SEM_REL_VER} \
    @semantic-release/gitlab@${SEM_REL_GITLAB_VER} \
    conventional-changelog-conventionalcommits@${CCCC_VER}
