FROM ubuntu:raring
MAINTAINER Michael Stogowski, michael@stogiapps.com

RUN apt-get update
RUN apt-get -yyy upgrade
RUN apt-get -yyy install supervisor

RUN mkdir -p /var/log/supervisor
RUN mkdir -p /etc/supervisor/conf.d
ADD etc/supervisor/supervisord.conf /etc/supervisor/supervisord.conf

ADD http://download-new.utorrent.com/endpoint/utserver/os/linux-x64-ubuntu-13-04/track/beta/ /opt/utserver.tar.gz
RUN tar -C /opt -xvzf /opt/utserver.tar.gz
RUN mv /opt/utorrent-server-alpha-v3_3 /opt/utserver
ADD etc/supervisor/conf.d/utserver.sv.conf /etc/supervisor/conf.d/utserver.sv.conf

EXPOSE 6881
EXPOSE 8080

VOLUME /mnt/data

CMD supervisord -c /etc/supervisor/supervisord.conf
