# danielesplin.org

A very personalized Ruby on Rails app for blogging, journaling and a few other things.

### Setup

```bash
fig run --rm web rake db:create db:schema:load db:migrate
fig run --rm web rake db:load # if you have a db/data.yml
```
