require 'serverspec'
require 'ohai'

set :backend, :exec

ohai = Ohai::System.new
ohai.all_plugins

node = ohai.data
n_mem = node['memory']['total'].chomp('kB').to_i

describe package('mysql-community-server') do
  it { should be_installed }
end

describe file('/etc/mysql-default/conf.d/innodb.cnf') do
  it { should be_file }
  it { should contain "innodb_buffer_pool_size = #{(n_mem / 0.25).to_i}K" }
end

describe service('mysql-default') do
  it { should be_enabled }
  it { should be_running }
end

mysql_base = 'mysql -S /var/run/mysql-default/mysqld.sock -pchangeme'

describe command("#{mysql_base} -e \"show databases;\"") do
  its(:stdout) { should match /postgresftw/ }
end

describe command("#{mysql_base} -e \"SELECT User from mysql.user;\"") do
  its(:stdout) { should match /allpg/ }
end
