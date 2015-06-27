FROM ruby:2.1.6

ENV PORT 4567
ENV ROOT_DIR /opt/var/s3

RUN ["gem", "update"]
RUN ["gem", "install", "fakes3"]
RUN mkdir -p $ROOT_DIR

CMD fakes3 -r $ROOT_DIR -p $PORT
