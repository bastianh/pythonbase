#!/bin/sh
chown redis /var/lib/redis
sysctl vm.overcommit_memory=1 > /dev/null 2>&1
exec /sbin/setuser redis /usr/bin/redis-server /etc/redis/redis.conf > /dev/null 2>&1
