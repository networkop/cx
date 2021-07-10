FROM debian:buster-slim

RUN apt update && apt install -y openssh-server \
    python3-apt ntp lldpd ifupdown2 python-apt iputils-ping tcpdump traceroute
RUN mkdir /run/sshd 

RUN echo "root:root" | chpasswd
RUN sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#AuthorizedKeysFile.*/AuthorizedKeysFile     \.ssh\/authorized_keys/' /etc/ssh/sshd_config

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
