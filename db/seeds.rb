ENV['FIXTURES_PATH'] = 'db/seeds'
Rake::Task['db:fixtures:load'].invoke
User.find_each do |user|
  warn "login: #{user.email}, password: #{user.email}, role: #{user.role}"
  user.update!(password: user.email, password_confirmation: user.email)
end
