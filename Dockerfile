#FROM ruby:2.2.2
FROM ubuntu:14.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y ruby ruby-dev
RUN gem install bundler

RUN apt-get install -y libphash0-dev libpng-dev libjpeg-dev imagemagick

ADD . /app
WORKDIR /app

RUN bundle install

ENTRYPOINT bundle exec ruby download_and_compare
