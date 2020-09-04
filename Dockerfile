FROM golang:1.15-alpine as build

ENV CGO_ENABLED 0

RUN apk add --no-cache ca-certificates git && \
      go get \
      github.com/Sirupsen/logrus \
      github.com/armed/mkdirp \
      github.com/cimpress-mcp/gosecret/api \
      github.com/hashicorp/consul/api \
      github.com/cimpress-mcp/fsconsul

WORKDIR /go/src/github.com/cimpress-mcp/fsconsul
RUN go install

FROM alpine:latest
COPY --from=build /go/bin/fsconsul /bin/fsconsul
CMD ["fsconsul"]
