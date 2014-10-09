FROM rails:onbuild
MAINTAINER Daniel Esplin <daniel@danielesplin.org>
ENV LC_ALL C.UTF-8
RUN RAILS_ENV=production bin/rake assets:precompile
