FROM docker

RUN mkdir /rclone
WORKDIR /rclone
ADD . .

WORKDIR builder
CMD ["sh", "/rclone/entrypoint.sh"]
