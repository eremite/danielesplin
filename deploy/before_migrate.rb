resource = new_resource

file "#{resource.shared_path}/config/application.yml" do
  owner resource.user
  group resource.group
  mode '0660'
  content resource.params[:deploy_data]['environment_variables'].map { |k, v| "#{k.upcase}: #{v}" }.join("\n")
  action :create
  only_if { ::File.exists?(resource.current_path)}
end

directory "#{resource.shared_path}/assets" do
  owner resource.user
  group resource.group
  mode '0660'
  action :create
  recursive true
end

link "#{resource.current_path}/public/assets" do
  to "#{resource.shared_path}/assets"
end

execute 'rake assets:precompile' do
  cwd resource.current_path
  command 'bundle exec rake assets:precompile'
  environment 'RAILS_ENV' => resource.environment['RAILS_ENV']
  only_if { ::File.exists?(resource.current_path)}
end
