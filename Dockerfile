FROM debian:bullseye-slim AS debian-image

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get -qq -y update \
    && apt-get -qq -y install --no-install-recommends apt-utils > /dev/null \
    && apt-get -qq -y install ca-certificates coreutils curl > /dev/null \
    && apt-get -qq clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

FROM fluent/fluent-bit:2.0.6
COPY --from=debian-image / /debian/
COPY fluent-bit/etc/ /fluent-bit/etc/
