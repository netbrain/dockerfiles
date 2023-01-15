#!/bin/bash

# Set the container image to use
IMAGE=${IMAGE:-docker.io/netbrain/scrcpy}

# The container version
VERSION=${VERSION:-latest}

# Check for updated container image
docker pull $IMAGE:$VERSION

# Check for proprietary nvidia driver and set correct device to use
if [[ -f "/proc/driver/nvidia/version" ]]
then
	VGA_DEVICE_FLAG="--gpus all"
else
	VGA_DEVICE_FLAG="--device /dev/dri:/dev/dri"
fi

ARGS="$@"
if [[ -z "$ARGS" ]]
then
	ARGS="scrcpy"
fi

# Create the container
CONTAINER=$(docker create \
	--rm \
	--privileged \
	--network=host \
	-e DISPLAY=$DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	$VGA_DEVICE_FLAG \
	$IMAGE:$VERSION $ARGS)
	
# Allow container to connect to X
xhost +local:$(docker inspect --format='{{ .Config.Hostname  }}' $CONTAINER)

docker start -ia $CONTAINER
