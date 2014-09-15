name             'heapstats'
maintainer       'Norito AGETSUMA'
license          'Apache License, Version 2.0'
description      'Installs/Configures heapstats'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

recipe "heapstats::default", "check heapstats supported platform, and install heapstats dependent package"
recipe "heapstats::java_centos", "install jdk with debuginfo for centos"
recipe "heapstats::java_fedora", "install jdk with debuginfo for fedora"
recipe "heapstats::heapstats", "install heapstats agent"

%w{centos fedora}.each do |os|
  supports os
end

depends 'java'
