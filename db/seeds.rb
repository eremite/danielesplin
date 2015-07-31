puts 'Loading fixtures.'
ENV['FIXTURES_PATH'] = 'db/seeds'
Rake::Task['db:fixtures:load'].invoke
