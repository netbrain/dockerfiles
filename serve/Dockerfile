FROM golang:1.17
WORKDIR /go/src/app
COPY . .
ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64
RUN go build -ldflags '-w -extldflags "-static"' -o serve -a main.go

FROM scratch
COPY --from=0 /go/src/app/serve /serve
EXPOSE 8080/tcp
ENTRYPOINT ["/serve"]
