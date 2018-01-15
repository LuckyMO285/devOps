#
# Cookbook Name:: example2
# Recipe:: default
#
# Copyright 2015, Leonid Laboshin
#
# Create the /etc/ntp.conf file using the
# template Chef resource and populate it with the array of servers
# from the node attribute node['example2']['ntp_servers']

package 'ntp'

# Add the template here

template '/etc/ntp.conf' do
  source 'ntp.erb'
  mode '0440'
  owner 'root'
  group 'root'
  variables(ntp_servers: node['example2']['ntp_servers'])
end

service 'ntp' do
  action [:enable, :start]
end
