#
# Cookbook Name:: mynginx
# Recipe:: default
#
# Copyright 2017, Steven Goodstein
#
# All rights reserved - Do Not Redistribute
#

include_recipe  "nginx::source"

template '/etc/nginx/nginx.conf' do
  source 'nginx.conf.erb'
end
