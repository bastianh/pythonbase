#!/bin/sh

exec /sbin/setuser nobody /usr/local/bin/flower --broker=amqp://guest:guest@localhost:5672// --port=5555 > /dev/null 2>&1
