#
# Cookbook Name:: example3
# Recipe:: default
#
# Copyright 2015, Leonid Laboshin
package 'nginx'
package 'git'

directory '/var/www' do
	owner 'root'
	group 'root'
	mode '0755'
	action :create
end
	
git 'git_clone' do
	destination '/var/www/magic' 
	repository 'git://github.com/jarosser06/magic.git'
end

template '/etc/nginx/sites-available/magic.conf' do
	source 'magic.conf.erb'
	mode '0440'
	owner 'root'
	group 'root'
	variables(server_name: 'nginx-server', root: '/root')
end

service 'nginx' do
	action [:enable, :start]
	subscribes :reload, 'file[/etc/nginx/sites-available/magic.conf]', :immediately
end

link '/etc/nginx/sites-enabled/magic.conf' do
  to '/etc/nginx/sites-available/magic.conf'
end
