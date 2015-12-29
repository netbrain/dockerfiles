#!/bin/bash
cd init
docker build -t rclone-init .
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock rclone-init
docker rmi rclone-init

echo "Completed building netbrain/rclone"
