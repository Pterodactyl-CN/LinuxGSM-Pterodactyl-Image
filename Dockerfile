#
# LinuxGSM Dockerfile
#
# https://github.com/GameServerManagers/LinuxGSM-Docker
#

FROM ubuntu:16.04
LABEL maintainer="LinuxGSM-Pter-CN <xjdzch@126.com>"

ENV DEBIAN_FRONTEND noninteractive
 
RUN sed -i 's/archive.ubuntu.com/mirrors.163.com/g' /etc/apt/sources.list
RUN  dpkg --add-architecture i386
RUN  apt update -y 
RUN  apt -y install mailutils postfix curl wget file bzip2 gzip unzip bsdmainutils python util-linux ca-certificates binutils bc tmux lib32gcc1 libstdc++6 libstdc++6:i386 lib32tinfo5 sudo		
RUN apt-get clean		
RUN echo "container ALL=(ALL) NOPASSWD: ALL"    >> /etc/sudoers
RUN wget -O /usr/bin/lgsmcore https://raw.githubusercontent.com/GameServerManagers/LinuxGSM/master/linuxgsm.sh >> /dev/null
RUN chmod +x /usr/bin/lgsmcore /dev/null
RUN adduser  -u 993 --gecos "" container
#RUN exec &&  echo 'lgsmcore' | passwd container --stdin >> /dev/null

USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash"]
