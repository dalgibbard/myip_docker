#!/bin/ash
mkfifo -m 600 /tmp/logpipe
cat < /tmp/logpipe 1>&2 &
chown www-data /tmp/logpipe
/usr/sbin/lighttpd -D -f /etc/lighttpd/lighttpd.conf
