FROM docker.io/library/node:24.15.0-alpine@sha256:d1b3b4da11eefd5941e7f0b9cf17783fc99d9c6fc34884a665f40a06dbdfc94f

# renovate: datasource=npm depName=semantic-release
ENV SEM_REL_VER="25.0.3"
# renovate: datasource=npm depName=conventional-changelog-conventionalcommits
ENV CCCC_VER="9.3.0"
# renovate: datasource=npm depName=@semantic-release/gitlab
ENV SEM_REL_GITLAB_VER="13.3.2"

RUN apk update && apk upgrade && \
    apk add git && \
    apk cache clean

WORKDIR /semantic-release-bot

RUN npm install -g semantic-release@${SEM_REL_VER} \
    @semantic-release/gitlab@${SEM_REL_GITLAB_VER} \
    conventional-changelog-conventionalcommits@${CCCC_VER}
