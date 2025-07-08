FROM docker.io/library/node:22.17.0-alpine@sha256:3d5fc849018cfc7e3d770820582857fb6c8d88eb10db7d3af699e8cf81b9e551

# renovate: datasource=npm depName=semantic-release
ENV SEM_REL_VER="24.2.5"
# renovate: datasource=npm depName=conventional-changelog-conventionalcommits
ENV CCCC_VER="9.0.0"
# renovate: datasource=npm depName=@semantic-release/gitlab
ENV SEM_REL_GITLAB_VER="13.2.6"

RUN apk update && apk upgrade && \
    apk add git && \
    apk cache clean

WORKDIR /semantic-release-bot

RUN npm install -g semantic-release@${SEM_REL_VER} \
    @semantic-release/gitlab@${SEM_REL_GITLAB_VER} \
    conventional-changelog-conventionalcommits@${CCCC_VER}
