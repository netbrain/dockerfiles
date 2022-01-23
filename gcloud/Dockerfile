# docker run --rm \
#	-it \
#	-v $HOME/.config/gcloud:/home/user/.config/gcloud \
#	--user $(id -u):$(id -g) \
#	netbrain/gcloud

FROM debian:jessie
ENV SHELL /bin/bash
ENV HOME /home/user
RUN mkdir -p /home/user
RUN chmod 755 /home/user
RUN apt-get update && apt-get -y install curl python openssh-client

WORKDIR /home/user
RUN curl https://sdk.cloud.google.com | bash

ENTRYPOINT ["/home/user/google-cloud-sdk/bin/gcloud"]
CMD ["init"]
