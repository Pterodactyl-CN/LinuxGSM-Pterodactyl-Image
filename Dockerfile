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
RUN  apt -y install binutils mailutils postfix bc curl wget file bzip2 gzip unzip xz-utils libmariadb2 bsdmainutils python util-linux ca-certificates tmux lib32gcc1 libstdc++6 libstdc++6:i386 libstdc++5:i386 libsdl1.2debian default-jdk lib32tinfo5 speex:i386 libtbb2 libcurl4-gnutls-dev:i386 libtcmalloc-minimal4:i386 libncurses5:i386 zlib1g:i386 libldap-2.4-2:i386 libxrandr2:i386 libglu1-mesa:i386 libxtst6:i386 libusb-1.0-0-dev:i386 libxxf86vm1:i386 libopenal1:i386 libssl1.0.0:i386 libgtk2.0-0:i386 libdbus-glib-1-2:i386 libnm-glib-dev:i386 lib32z1 sudo
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

CMD ["/bin/bash", "/entrypoint.sh"]
