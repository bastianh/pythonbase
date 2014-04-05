
FROM dafire/baseimage-docker

# Set correct environment variables.
ENV HOME /root

# local speedup
#ENV PIP_INDEX_URL http://172.17.42.1:3141/root/pypi/+simple

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
#RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN apt-get update

RUN apt-get install -y python-software-properties git

RUN add-apt-repository ppa:fkrull/deadsnakes
RUN add-apt-repository ppa:pitti/postgresql
RUN add-apt-repository ppa:chris-lea/redis-server 

RUN apt-get update
RUN apt-get install -y python3.4 python3.4-dev libpq-dev g++ libfreetype6-dev libpng-dev redis-server memcached

RUN python3.4 -m ensurepip --upgrade

# install some common packages
RUN pip3.4 install numpy matplotlib certifi psycopg2 redis hiredis

RUN mkdir /etc/service/redis
ADD redis.sh /etc/service/redis/run

RUN mkdir /etc/service/memcached
ADD memcached.sh /etc/service/memcached/run

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
