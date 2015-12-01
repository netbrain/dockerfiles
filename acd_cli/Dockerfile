#WIP
#docker run --rm --name acd_cli -v $HOME/dev/.secret/.secrets.d/amazon-cloud-drive.json:/root/.cache/acd_cli/client_data -it netbrain/acd_cli
FROM debian:jessie

RUN apt-get update && apt-get -y install python3 python3-pip git
RUN pip3 install --upgrade git+https://github.com/yadayada/acd_cli.git
ENTRYPOINT acd_cli
