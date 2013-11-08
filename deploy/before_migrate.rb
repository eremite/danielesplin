resource = new_resource
rails_environment = resource.environment['RAILS_ENV']

  Chef::Log.info("Precompiling assets for RAILS_ENV=#{rails_environment}...")
  execute 'rake assets:precompile' do
    cwd resource.current_path
    command 'bundle exec rake assets:precompile'
    environment 'RAILS_ENV' => rails_environment
  end

  template "#{resource.current_path}/shared/config/application.yml" do
    source "#{resource.current_path}/deploy/templates/application.yml.erb"
    mode '0660'
    group resource.group
    owner resource.user
    variables(:environment_variables => resource.params[:deploy_data]['environment_variables'])
    only_if do
      File.exists?("#{resource.current_path}") && File.exists?("#{resource.current_path}/shared/config/")
    end
  end

end
