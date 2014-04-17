#!/bin/sh

exec /sbin/setuser memcached /usr/bin/memcached > /dev/null 2>&1
