#!/bin/sh

exec /sbin/setuser rabbitmq /usr/sbin/rabbitmq-server > /dev/null 2>&1
