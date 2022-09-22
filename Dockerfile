FROM golang:1.18-alpine

WORKDIR /build

RUN apk update && \
    apk add git && \
    go mod init getmyip && \
    go get github.com/mliezun/grotsky/cmd/grotsky@v0.0.0-20201218181624-4d6c19dfd9ea && \
    go build $(go env GOPATH)/pkg/mod/github.com/mliezun/grotsky@v0.0.0-20201218181624-4d6c19dfd9ea/cmd/grotsky


FROM alpine:3.12

WORKDIR /app

COPY --from=0 /build/grotsky /app/grotsky

COPY getmyip.g /app/getmyip.g

CMD ["/app/grotsky", "/app/getmyip.g"]
