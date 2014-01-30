resource = new_resource

file "#{resource.shared_path}/config/secrets.yml" do
  owner resource.user
  group resource.group
  mode '0660'
  content resource.params[:deploy_data]['secrets'].map { |k, v| "production:\n  #{k.upcase}: '#{v}'" }.join("\n")
  action :create
  only_if { ::File.exists?(resource.shared_path) }
end

execute 'rake assets:precompile' do
  cwd release_path
  command 'bundle exec rake assets:precompile'
  environment 'RAILS_ENV' => resource.environment['RAILS_ENV']
  only_if { ::File.exists?(release_path) }
end
