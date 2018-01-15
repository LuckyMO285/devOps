require 'serverspec'

set :backend, :exec

describe package('nginx') do
  it { should be_installed }
end

describe file('/etc/nginx/sites-available/magic.conf') do
  it { should be_file }
end

describe file('/etc/nginx/sites-enabled/magic.conf') do
  it { should be_symlink }
  it { should be_linked_to '/etc/nginx/sites-available/magic.conf' }
end

describe file('/var/www/magic') do
  it { should be_directory }
end

describe port(80) do
  it { should be_listening }
end

describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end
