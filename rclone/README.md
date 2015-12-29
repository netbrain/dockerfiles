The build.sh script creates a docker in docker environment which builds a scratch image of rclone using godockerize

USAGE

1. Create config:

docker run -it --rm --net=host -v /etc/ssl/certs/ca-certificates.crt:/etc/ssl/certs/ca-certificates.crt -v $HOME/.rclone.conf:/.rclone.conf netbrain/rclone config

2. Use rclone

docker run -it -v /etc/ssl/certs/ca-certificates.crt:/etc/ssl/certs/ca-certificates.crt -v $HOME/.rclone.conf:/.rclone.conf netbrain/rclone


