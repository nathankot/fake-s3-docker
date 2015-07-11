FROM ruby:2.1.6

ENV PORT 443
ENV HOST_NAME s3.amazonaws.com

RUN ["gem", "update"]
RUN ["gem", "install", "fakes3"]
RUN mkdir -p /opt/var/s3

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

CMD fakes3 -r /opt/var/s3 \
           -p $PORT \
           -H $HOST_NAME \
           --sslcert=/etc/ssl/certs/fakes3.pem \
           --sslkey=/etc/ssl/certs/fakes3.key
