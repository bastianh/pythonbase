FROM dafire/baseimage-docker

# Set correct environment variables.
ENV HOME /root

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
#RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN apt-get update

RUN apt-get install -y python-software-properties git

RUN add-apt-repository -y ppa:fkrull/deadsnakes
RUN add-apt-repository -y ppa:chris-lea/redis-server 

ADD apt.postgresql.org.sh /tmp/apt.postgresql.org.sh
RUN chmod +x /tmp/apt.postgresql.org.sh
RUN /tmp/apt.postgresql.org.sh
RUN rm /tmp/apt.postgresql.org.sh

RUN apt-get update
RUN apt-get install -y python3.4 python3.4-dev libpq-dev g++ libfreetype6-dev libpng-dev redis-server memcached postgresql-client-9.3

RUN python3.4 -m ensurepip --upgrade

# install some common packages
ADD requirements.txt /tmp/requirements.txt
RUN pip3.4 install -r /tmp/requirements.txt
RUN rm /tmp/requirements.txt

RUN mkdir /etc/service/redis
RUN sed -i.bak "s/daemonize yes/daemonize no/g" /etc/redis/redis.conf
VOLUME ["/var/lib/redis"]
ADD redis.sh /etc/service/redis/run

RUN mkdir /etc/service/memcached
ADD memcached.sh /etc/service/memcached/run

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
