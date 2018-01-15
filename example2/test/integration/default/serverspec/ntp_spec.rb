require 'serverspec'

set :backend, :exec

describe package('ntp') do
  it { should be_installed }
end

describe file('/etc/ntp.conf') do
  it { should contain '3.pool.ntp.org' }
end

describe service('ntp') do
  it { should be_enabled }
  it { should be_running }
end
