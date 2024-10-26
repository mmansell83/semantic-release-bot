FROM docker.io/library/node:22.10.0-alpine

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
