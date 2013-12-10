resource = new_resource
execute 'delayed_job restart' do
  cwd release_path
  command 'bin/delayed_job restart'
  environment 'RAILS_ENV' => resource.environment['RAILS_ENV']
  only_if { ::File.exists?(release_path)}
end
