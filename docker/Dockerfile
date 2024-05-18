FROM golang:1.21.5-alpine AS builder

WORKDIR /go/src/github.com/matopenKW/go-cicd/

ENV CGO_ENABLED=0

COPY . .

RUN go install -v -tags netgo -ldflags '-extldflags "-static"' ./cmd/http
RUN go install -v -tags netgo -ldflags '-extldflags "-static"' ./cmd/cli

FROM alpine AS server

RUN apk add ca-certificates
COPY --from=builder /go/bin/http /bin/http
COPY --from=builder /go/bin/cli /bin/cli

WORKDIR /go/src/github.com/matopenKW/go-cicd/
