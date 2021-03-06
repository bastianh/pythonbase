FROM phusion/baseimage:0.9.15

# Set correct environment variables.
ENV HOME /root

# disable ssh ... we use docker-bash to connect to the container
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh


# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# install python stuff

RUN apt-get update
RUN apt-get install -y python3.4 python3.4-dev libpq-dev g++ libfreetype6-dev libpng-dev python3-pip git
RUN apt-get install -y rabbitmq-server ruby npm nodejs-legacy

RUN npm install -g react-tools
RUN gem install --no-ri --no-rdoc sass

#evil .. :/ but freetype headers are not found otherwise
RUN cp -ar /usr/include/freetype2/* /usr/local/include/

ADD requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt
RUN rm /tmp/requirements.txt

# add other stuff and services

RUN mkdir /etc/service/rabbitmq
ADD rabbit_enabled_plugins /etc/rabbitmq/enabled_plugins
ADD rabbitmq.sh /etc/service/rabbitmq/run

RUN apt-get install -y redis-server memcached postgresql-client-9.3
RUN mkdir /etc/service/redis
RUN sed -i.bak "s/daemonize yes/daemonize no/g" /etc/redis/redis.conf
RUN sed -i.bak "s/var\/lib\/redis/app\/lib\/redis/g" /etc/redis/redis.conf
ADD redis.sh /etc/service/redis/run

RUN mkdir /etc/service/memcached
ADD memcached.sh /etc/service/memcached/run

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
