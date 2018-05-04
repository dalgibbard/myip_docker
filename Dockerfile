FROM alpine
MAINTAINER Darren Gibbard <dalgibbard@gmail.com>
RUN apk --update --no-cache add --repository http://dl-cdn.alpinelinux.org/alpine/edge/main --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
  lighttpd \
  php7-common \
  php7-cgi \
  fcgi \
  php7-posix \
  php7-gettext && \
  rm -rf /var/cache/apk/*
RUN adduser www-data -G www-data -H -s /bin/false -D
RUN mkdir /run/lighttpd && chown www-data /run/lighttpd
ADD lighttpd.conf /etc/lighttpd/lighttpd.conf
ADD docker-entrypoint.sh /
RUN echo '<?php $IPA = $_SERVER["HTTP_X_FORWARDED_FOR"]; $IPB = $_SERVER["REMOTE_ADDR"]; echo $IPA; echo $IPB; ?>' > /var/www/index.php
#RUN echo '<?php if (isset ($_SERVER["HTTP_X_FORWARDED_FOR"])){ $IP = $_SERVER["HTTP_X_FORWARDED_FOR"]; } else { $IP = $_SERVER["REMOTE_ADDR"]; } echo $IP; ?>' > /var/www/index.php
EXPOSE 80
ENTRYPOINT ["/docker-entrypoint.sh"]
