ARG GOSU_VERSION=1.12
ARG ALPINE_VERSION=3.12
FROM alpine:$ALPINE_VERSION as scratch
ARG GOSU_VERSION
ENV GOSU_VERSION=$GOSU_VERSION
RUN set -eux; \
	\
	apk add --no-cache --virtual .gosu-deps \
        ca-certificates \
		dpkg \
		gnupg \
	; \
	\
	dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
	wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
	wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"; \
	\
# verify the signature
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
	gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
    command -v gpgconf && gpgconf --kill all || :; \
	\
	chmod +x /usr/local/bin/gosu; \
# verify that the binary works
    gosu --version; \
	gosu nobody true;

FROM alpine:$ALPINE_VERSION
ARG GOSU_VERSION
ENV GOSU_VERSION $GOSU_VERSION
COPY --from=scratch /usr/local/bin/gosu /usr/local/bin/
