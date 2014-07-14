# Install required development tools, Go and fpm
include_recipe 'build-essential::default'
include_recipe 'golang::default'

# Install rpmbuild required for building RPM.
# Crap! Why FPM do not install them?
# Why this is not a part with build-essential? Damn!
package 'rpm-build' do
  action :install
  only_if { platform_family?('rhel', 'fedora') }
end

# Install FPM ruby gem
chef_gem 'fpm' do
  action :install
end

# Clenaup logstash-forwarder directory and remove logstash package
directory "#{Chef::Config['file_cache_path']}/#{node['logstash-forwarder-package']['name']}" do
  recursive true
  action :delete
  only_if { ::File.directory?("#{Chef::Config['file_cache_path']}/#{node['logstash-forwarder-package']['name']}") }
end
package node['logstash-forwarder-package']['name'] do
  action :remove
  ignore_failure true
end

# Clone logstash-forwarder from github
git "#{Chef::Config['file_cache_path']}/#{node['logstash-forwarder-package']['name']}" do
  repository node['logstash-forwarder-package']['git']
  reference node['logstash-forwarder-package']['reference']
  action :sync
end

# Build and package logstash-forwarder
execute 'build_and_package_logstash_forwarder' do
  user 'root'
  environment('PATH' => node['logstash-forwarder-package']['path'].join(':'))
  path node['logstash-forwarder-package']['path']
  cwd "#{Chef::Config['file_cache_path']}/#{node['logstash-forwarder-package']['name']}"
  command "go build && make #{node['logstash-forwarder-package']['package_type']} && cp -f *.#{node['logstash-forwarder-package']['package_type']} #{node['logstash-forwarder-package']['shared_folder']}/"
  action :run
  only_if { ::File.directory?("#{Chef::Config['file_cache_path']}/#{node['logstash-forwarder-package']['name']}") || ::File.directory?("#{Chef::Config['file_cache_path']}/#{node['logstash-forwarder-package']['shared_folder']}") }
end

# Test package deployment
Dir.glob("#{Chef::Config['file_cache_path']}/#{node['logstash-forwarder-package']['name']}/*.#{node['logstash-forwarder-package']['package_type']}").each do |lspkg|
  package lspkg.split("/").last do
    source lspkg
    action :install
  end
end
