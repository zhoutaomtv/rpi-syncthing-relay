FROM arm32v6/golang:1.9-alpine AS builder
LABEL maintainer="Toddy Zhou <zhoutaomtv@gmail.com>"

ENV PKGVER   0.14.49

# Busybox wget needs TLS support, curl is less painful to get working
RUN apk add --no-cache ca-certificates curl && \
    mkdir /go1 || true && \
    cd /go1 && \
    mkdir -p src/github.com/syncthing && \
    export SRCDIR=$PWD && \
    cd src/github.com/syncthing && \
    curl -L https://github.com/syncthing/syncthing/releases/download/v$PKGVER/syncthing-source-v${PKGVER}.tar.gz | tar xzf - && \
    cd syncthing && \
    export GOPATH="$SRCDIR" GOROOT_FINAL="/usr/bin" && \
    go run build.go -no-upgrade -version v${PKGVER} build strelaysrv

#Building thin container
FROM arm32v6/alpine:3.8

RUN apk add --no-cache ca-certificates
COPY --from=builder /go1/src/github.com/syncthing/syncthing/strelaysrv /usr/bin/strelaysrv

# Run unprivileged out of /relaysrv
RUN mkdir /relaysrv && chown nobody:nobody /relaysrv
VOLUME /relaysrv
USER nobody
WORKDIR /relaysrv

EXPOSE 22067 22070

ENTRYPOINT ["/usr/bin/strelaysrv"]
CMD [""]
