ARG BUILD_IMAGE=alpine:3

FROM $BUILD_IMAGE as build
ARG STUNNEL_VERSION

RUN apk add --no-cache "stunnel=${STUNNEL_VERSION}" && \
  mkdir /opt/stunnel

USER stunnel
WORKDIR /opt/stunnel

COPY --chown=stunnel:stunnel stunnel.conf entrypoint.sh ./

CMD ["/bin/sh", "/opt/stunnel/entrypoint.sh"]
