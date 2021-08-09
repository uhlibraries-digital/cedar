FROM ruby:2.2.4

RUN apt-get update -q && apt-get install -y \
  build-essential \
  nodejs

RUN mkdir /cedar-app
WORKDIR /cedar-app

ADD Gemfile /cedar-app/Gemfile
ADD Gemfile.lock /cedar-app/Gemfile.lock

COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

RUN gem install bundler -v 1.17.3  && bundle install
ADD . /cedar-app