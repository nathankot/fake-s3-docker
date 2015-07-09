FROM ruby:2.1.6

ENV PORT 443
ENV ROOT_DIR /opt/var/s3
ENV HOST_NAME s3.amazonaws.com

RUN ["gem", "update"]
RUN ["gem", "install", "fakes3"]
RUN mkdir -p $ROOT_DIR

RUN openssl req \
  -new \
  -x509 \
  -days 365 \
  -nodes \
  -out /etc/ssl/certs/fakes3.pem \
  -keyout /etc/ssl/certs/fakes3.key \
  -subj "/C=US/ST=Fake/L=S3/O=FakeS3/CN=*.$HOST_NAME"

RUN chmod 0600 /etc/ssl/certs/fakes3.pem
RUN chmod 0600 /etc/ssl/certs/fakes3.key

CMD fakes3 -r $ROOT_DIR \
           -p $PORT \
           -H $HOST_NAME \
           --sslcert=/etc/ssl/certs/fakes3.pem \
           --sslkey=/etc/ssl/certs/fakes3.key
