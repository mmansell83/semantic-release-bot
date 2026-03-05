FROM docker.io/library/node:24.13.0-alpine@sha256:931d7d57f8c1fd0e2179dbff7cc7da4c9dd100998bc2b32afc85142d8efbc213

# renovate: datasource=npm depName=semantic-release
ENV SEM_REL_VER="25.0.2"
# renovate: datasource=npm depName=conventional-changelog-conventionalcommits
ENV CCCC_VER="9.3.0"
# renovate: datasource=npm depName=@semantic-release/gitlab
ENV SEM_REL_GITLAB_VER="13.2.9"

RUN apk update && apk upgrade && \
    apk add git && \
    apk cache clean

WORKDIR /semantic-release-bot

RUN npm install -g semantic-release@${SEM_REL_VER} \
    @semantic-release/gitlab@${SEM_REL_GITLAB_VER} \
    conventional-changelog-conventionalcommits@${CCCC_VER}
