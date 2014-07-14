name 'logstash-forwarder-package'
maintainer 'Myroslav Rys'
maintainer_email 'stonevil@gmail.com'
license 'GNU GPL'
description 'Build for logstash-forwarder package'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'

depends 'packages-update'
depends 'apt'
depends 'yum'
depends 'rvm'
depends 'golang'
depends 'build-essential'
