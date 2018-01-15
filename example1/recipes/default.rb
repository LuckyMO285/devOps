#
# Cookbook Name:: example1
# Recipe:: default
#
# Copyright 2015, Leonid Laboshin
#
# The NTP service should be installed, and the it should
# have the following populated in the ntp config:
#
package 'ntp'

file '/etc/ntp.conf' do
	content 'server 0.pool.ntp.org'\
		'server 1.pool.ntp.org'\
		'server 2.pool.ntp.org'
end

service 'ntpd' do
	action [:enable,:start]
end
#
# Make sure the service gets enabled and started
 
