#
# Cookbook:: myrvm
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

apt_update 'Update the apt cache daily' do
  frequency 86_400
  action :periodic
end

node.default['rvm']['global_gems'] = [
  { 'name'    => 'bundler' },
  { 'name'    => 'rake',
    'version' => '0.9.2'
  },
  { 'name'    => 'rubygems-bundler',
    'action'  => 'remove'
  }
]

include_recipe 'rvm::system'

rvm_default_ruby "ruby-2.3.0"
