#!/bin/sh

exec /sbin/setuser memcache /usr/bin/memcached > /dev/null 2>&1
