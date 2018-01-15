#
# Cookbook Name:: example4
# Recipe:: default
#
# Copyright 2015, Leonid Laboshin
#

mysql_service 'default' do
        port '3306'
        version '5.5'
        initial_root_password 'password'
        action [:create, :start]             
end

template 'innodb.cnf' do
        source 'innodb.cnf.erb' 
end
