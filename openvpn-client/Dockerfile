#docker run -it --dns 8.8.8.8 -v /path/to/secret.vpn.config:/vpn.conf --cap-add=NET_ADMIN --device=/dev/net/tun --name vpn netbrain/openvpn-client
FROM debian:jessie
RUN apt-get update && apt-get -y install openvpn
CMD ["openvpn","--config","/vpn.conf"]
