include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  Chef::Log.info("Precompiling assets for RAILS_ENV=#{deploy[:rails_env]}...")
  execute 'rake assets:precompile' do
    cwd deploy[:deploy_to]
    command 'bundle exec rake assets:precompile'
    environment 'RAILS_ENV' => deploy[:rails_env]
  end

  template "#{deploy[:deploy_to]}/shared/config/application.yml" do
    source "#{deploy[:deploy_to]}/deploy/templates/application.yml.erb"
    mode '0660'
    group deploy[:group]
    owner deploy[:user]
    variables(environment_variables: deploy[:environment_variables])
    only_if do
      File.exists?("#{deploy[:deploy_to]}") && File.exists?("#{deploy[:deploy_to]}/shared/config/")
    end
  end

end
