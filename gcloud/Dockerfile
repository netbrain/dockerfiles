#docker run --name gcloud -it netbrain/gcloud
FROM debian:jessie
ENV SHELL /bin/bash

RUN apt-get update && apt-get -y install curl python openssh-client

RUN curl https://sdk.cloud.google.com | bash

ENTRYPOINT ["/root/google-cloud-sdk/bin/gcloud"]
CMD ["init"]
