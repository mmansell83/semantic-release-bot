FROM docker.io/library/node:22.15.0-alpine@sha256:ad1aedbcc1b0575074a91ac146d6956476c1f9985994810e4ee02efd932a68fd

# renovate: datasource=npm depName=semantic-release
ENV SEM_REL_VER="24.2.5"
# renovate: datasource=npm depName=conventional-changelog-conventionalcommits
ENV CCCC_VER="8.0.0"
# renovate: datasource=npm depName=@semantic-release/gitlab
ENV SEM_REL_GITLAB_VER="13.2.5"

RUN apk update && apk upgrade && \
    apk add git && \
    apk cache clean

WORKDIR /semantic-release-bot

RUN npm install -g semantic-release@${SEM_REL_VER} \
    @semantic-release/gitlab@${SEM_REL_GITLAB_VER} \
    conventional-changelog-conventionalcommits@${CCCC_VER}
