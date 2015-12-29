docker build -t rclone-builder .
docker run --name rclone-builder rclone-builder
docker cp rclone-builder:/go/src/github.com/ncw/rclone /tmp
docker rm rclone-builder
docker rmi rclone-builder

cd /tmp/rclone
docker build -t netbrain/rclone .
