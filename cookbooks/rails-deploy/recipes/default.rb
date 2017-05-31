#
# Cookbook Name:: rails-deploy
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
home_directory = "/home/ubuntu"

deploy home_directory do
  repo "https://github.com/steve21168/hello-world"
  user "ubuntu"
  environment 'RAILS_ENV' => 'production', 'RAILS_SERVE_STATIC_FILES' => 'true'
  revision 'HEAD'
  action :deploy
  migration_command 'rake db:migrate --trace'
  migrate false
  symlink_before_migrate({})
  restart_command 'rails s -b 0.0.0.0 -d'

  before_restart do
    pid_path = "#{release_path}/tmp/pids/server.pid"
    if File.exists?(pid_path)
      execute "kill `cat #{pid_path}`"
    end
  end

  before_symlink do
    execute 'bundle install' do
      command "bundle install"
      user 'ubuntu'
      cwd release_path
    end

    execute 'Precompile assets' do
      command "rake assets:precompile"
      user 'ubuntu'
      cwd release_path
    end

    directory "#{home_directory}/shared/pids" do
      owner 'ubuntu'
      group 'ubuntu'
      mode '0755'
    end

    directory "#{home_directory}/shared/log" do
      owner 'ubuntu'
      group 'ubuntu'
      mode '0755'
    end
  end
  # enable_submodules true
  # migration_command "rake db:migrate"
  # migrate false
  # environment "RAILS_ENV" => "production"
  # scm_provider Chef::Provider::Git
  # action :deploy
  # git_ssh_wrapper "wrap-ssh4git.sh"
  # svn_username "whoami"
  # svn_password "supersecret"
end
