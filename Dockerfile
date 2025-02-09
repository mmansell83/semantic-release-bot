FROM docker.io/library/node:22.13.1-alpine@sha256:9861e45b6bcfee6115070bacd7daa1f10179bd95675b683fdba0de8aaa8f4269

# renovate: datasource=npm depName=semantic-release
ENV SEM_REL_VER="24.2.2"
# renovate: datasource=npm depName=conventional-changelog-conventionalcommits
ENV CCCC_VER="8.0.0"
# renovate: datasource=npm depName=@semantic-release/gitlab
ENV SEM_REL_GITLAB_VER="13.2.4"

RUN apk update && apk upgrade && \
    apk add git && \
    apk cache clean

WORKDIR /semantic-release-bot

RUN npm install -g semantic-release@${SEM_REL_VER} \
    @semantic-release/gitlab@${SEM_REL_GITLAB_VER} \
    conventional-changelog-conventionalcommits@${CCCC_VER}
