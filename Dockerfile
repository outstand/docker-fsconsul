FROM alpine:3.7

ENV FSCONSUL_VERSION 0.6.5

RUN apk add --no-cache ca-certificates wget gnupg openssl && \
    mkdir -p /tmp/build && \
    cd /tmp/build && \
    wget -O - https://keybase.io/outstand/pgp_keys.asc | gpg --import && \
    wget -O fsconsul "https://s3.amazonaws.com/outstand-publish/fsconsul-${FSCONSUL_VERSION}" && \
    wget -O fsconsul.asc "https://s3.amazonaws.com/outstand-publish/fsconsul-${FSCONSUL_VERSION}.asc" && \
    gpg --verify fsconsul.asc && \
    chmod +x fsconsul && \
    cp fsconsul /bin/fsconsul && \
    cd /tmp && \
    rm -rf /tmp/build && \
    apk del gnupg && \
    rm -rf /root/.gnupg
