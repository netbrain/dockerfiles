#!/bin/bash

# Set the container image to use
IMAGE=${IMAGE:-docker.io/netbrain/scrcpy}

# The container version
VERSION=${VERSION:-latest}

# Check for updated container image
docker pull $IMAGE:$VERSION

docker volume create scrcpy

ARGS="$@"
if [[ -z "$ARGS" ]]
then
	ARGS="scrcpy"
fi

# Create the container
CONTAINER=$(docker create \
	--rm \
	--ipc=host \
	-e DISPLAY=$DISPLAY \
	-v scrcpy:/home/user \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	$IMAGE:$VERSION $ARGS)
	
# Allow container to connect to X
xhost +local:$(docker inspect --format='{{ .Config.Hostname  }}' $CONTAINER)

docker start -ia $CONTAINER
