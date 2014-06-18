FROM phusion/baseimage
MAINTAINER Daniel Esplin <daniel@custombit.com>

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y build-dep ruby2.0
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install wget git libpq-dev postgresql-client libmagickwand-dev imagemagick
RUN DEBIAN_FRONTEND=noninteractive apt-get clean

ENV RUBY_VERSION 2.1.2
ENV RUBYGEMS_VERSION 2.2.2

# Install Ruby
RUN cd /tmp && wget --quiet http://cache.ruby-lang.org/pub/ruby/${RUBY_VERSION%.*}/ruby-${RUBY_VERSION}.tar.gz && tar -xzf ruby-${RUBY_VERSION}.tar.gz
RUN cd /tmp/ruby-${RUBY_VERSION} && ./configure --prefix=/usr/local --disable-install-rdoc && make && make install
RUN cd /tmp && wget --quiet http://production.cf.rubygems.org/rubygems/rubygems-${RUBYGEMS_VERSION}.tgz && tar -xzf rubygems-${RUBYGEMS_VERSION}.tgz
RUN cd /tmp/rubygems-${RUBYGEMS_VERSION} && ruby setup.rb && echo 'gem: --no-document' > /etc/gemrc
RUN gem install bundler

ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install

WORKDIR /app
