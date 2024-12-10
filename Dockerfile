# syntax=docker/dockerfile:1
# check=error=true

ARG RUBY_VERSION=3.3.4
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

WORKDIR /rails

# Install base packages
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 libssl-dev libreadline-dev zlib1g-dev autoconf \
      bison build-essential libyaml-dev libncurses5-dev libffi-dev libgdbm-dev libxml2-dev rustc pkg-config \
      libsqlite3-dev sqlite3 libvips ffmpeg poppler-utils && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

FROM base

EXPOSE 3000
CMD ["bin/devserver"]
