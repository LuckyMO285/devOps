require 'serverspec'

set :backend, :exec

describe package('mysql-community-server') do
  it { should be_installed }
end

describe file('/etc/mysql-default/conf.d/innodb.cnf') do
  it { should be_file }
  it { should contain 'innodb_buffer_pool_size = 128M' }
end

describe service('mysql-default') do
  it { should be_enabled }
  it { should be_running }
end
