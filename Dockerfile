FROM ruby:2.2.0

ENV LC_ALL C.UTF-8

RUN apt-get update && apt-get install -y mysql-client nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY Gemfile* /usr/src/app/
RUN bundle config --global jobs 8
RUN bundle install --system

COPY . /usr/src/app
RUN RAILS_ENV=production bin/rake assets:precompile

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
