FROM docker.io/library/node:24.10.0-alpine@sha256:775ba24d35a13e74dedce1d2af4ad510337b68d8e22be89e0ce2ccc299329083

# renovate: datasource=npm depName=semantic-release
ENV SEM_REL_VER="25.0.2"
# renovate: datasource=npm depName=conventional-changelog-conventionalcommits
ENV CCCC_VER="9.1.0"
# renovate: datasource=npm depName=@semantic-release/gitlab
ENV SEM_REL_GITLAB_VER="13.2.9"

RUN apk update && apk upgrade && \
    apk add git && \
    apk cache clean

WORKDIR /semantic-release-bot

RUN npm install -g semantic-release@${SEM_REL_VER} \
    @semantic-release/gitlab@${SEM_REL_GITLAB_VER} \
    conventional-changelog-conventionalcommits@${CCCC_VER}
