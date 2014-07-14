require 'chefspec'
require 'chefspec/berkshelf'

describe 'logstash-forwarder-package::default' do
  let(:platform) { 'centos' }
  let(:platform_version) { '6.5' }
  let(:chef_run) { ChefSpec::Runner.new(platform: platform, version: platform_version).converge(described_recipe) }

  before do
    stub_command("/usr/local/go/bin/go version | grep \"go1.2.2 \"").and_return(true)
  end

  it 'install package rpm-build' do
    expect(chef_run).to install_package('rpm-build')
  end
  it 'install chef package fpm' do
    expect(chef_run).to install_chef_gem('fpm')
  end
  it 'remove package logstash-forwarder' do
    expect(chef_run).to remove_package('logstash-forwarder')
  end
  it 'delete a folder' do
    expect(chef_run).to_not delete_directory("#{Chef::Config['file_cache_path']}/logstash-forwarder")
  end

  it 'sync a git' do
    expect(chef_run).to sync_git("#{Chef::Config['file_cache_path']}/logstash-forwarder").with(repository: 'https://github.com/elasticsearch/logstash-forwarder.git')
  end

end

at_exit { ChefSpec::Coverage.report! }
