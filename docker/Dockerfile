FROM golang:1.21.5-alpine AS builder

WORKDIR /go/src/github.com/matopenKW/go-cicd/

ENV CGO_ENABLED=0

COPY . .

RUN go install -v -tags netgo -ldflags '-extldflags "-static"' ./cmd/http

FROM alpine AS server

RUN apk add ca-certificates
COPY --from=builder /go/bin/http /bin/http

WORKDIR /go/src/github.com/matopenKW/go-cicd/

ENV PORT 8080

EXPOSE 8080
