FROM golang
RUN go get github.com/dahernan/godockerize

ENV APP github.com/ncw/rclone
RUN go get $APP
WORKDIR $GOPATH/src/$APP
CMD godockerize -scratch
