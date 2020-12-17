FROM golang:1.15-alpine3.12

WORKDIR /build

RUN apk update && \
    apk add git && \
    go get github.com/mliezun/grotsky/cmd/grotsky && \
    go build $(go env GOPATH)/src/github.com/mliezun/grotsky/cmd/grotsky


FROM alpine:3.12

WORKDIR /app

COPY --from=0 /build/grotsky /app/grotsky

COPY getmyip.g /app/getmyip.g

CMD ["/app/grotsky", "/app/getmyip.g"]