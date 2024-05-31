puts 'Loading fixtures.'
ENV['FIXTURES_PATH'] = 'db/seeds'
Rake::Task['db:fixtures:load'].invoke
User.all.each do |user|
  puts "login: #{user.email}, password: #{user.email}, role: #{user.role}"
  user.update!(password: user.email, password_confirmation: user.email)
end
