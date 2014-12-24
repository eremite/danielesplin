FROM rails:onbuild
MAINTAINER Daniel Esplin <daniel@danielesplin.org>
ENV LC_ALL C.UTF-8
RUN mkdir -p /data/danielesplin
WORKDIR /data/danielesplin
COPY . /data/danielesplin
RUN bundle config --global jobs 8
RUN bundle install --system
RUN RAILS_ENV=production bin/rake assets:precompile
