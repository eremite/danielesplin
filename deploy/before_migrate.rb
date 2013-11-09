resource = new_resource
rails_environment = resource.environment['RAILS_ENV']

file "#{resource.shared_path}/config/application.yml" do
  owner resource.user
  group resource.group
  mode '0660'
  content resource.params[:deploy_data]['environment_variables'].map { |k, v| "#{k.upcase}: #{v}" }.join("\n")
  action :create
  only_if { ::File.exists?(resource.current_path)}
end

Chef::Log.info("Precompiling assets for RAILS_ENV=#{rails_environment}...")
execute 'rake assets:precompile' do
  cwd resource.current_path
  command 'bundle exec rake assets:precompile'
  environment 'RAILS_ENV' => rails_environment
  only_if { ::File.exists?(resource.current_path)}
end

