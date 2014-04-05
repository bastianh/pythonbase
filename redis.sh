#!/bin/sh

sysctl vm.overcommit_memory=1
exec /sbin/setuser www-data /usr/bin/redis-server > /dev/null 2>&1
