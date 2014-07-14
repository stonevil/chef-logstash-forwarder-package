default['logstash-forwarder-package']['git'] = 'https://github.com/elasticsearch/logstash-forwarder.git'
default['logstash-forwarder-package']['reference'] = 'master'
default['logstash-forwarder-package']['name'] = 'logstash-forwarder'

# Go lang configuration
default['go']['version'] = '1.2.2'
default['go']['scm'] = 'false'

default['build-essential']['compile_time'] = true

default['logstash-forwarder-package']['package_type'] = value_for_platform_family(['rhel', 'fedora'] => 'rpm', 'debian' => 'deb')

default['logstash-forwarder-package']['shared_folder'] = '/files/default'
default['logstash-forwarder-package']['path'] = ["#{node['go']['install_dir']}/go/bin",
                                                 '/opt/chefdk/embedded/bin',
                                                 '/opt/chef/embedded/bin',
                                                 '/opt/chefdk/bin',
                                                 '/opt/chef/bin',
                                                 '/bin',
                                                 '/sbin',
                                                 '/usr/bin',
                                                 '/usr/sbin',
                                                 '/usr/local/bin',
                                                 '/usr/local/sbin']
