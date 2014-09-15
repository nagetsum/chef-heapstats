#
# Cookbook Name:: heapstats
# Recipe:: java_centos
#
# Copyright 2014, Norito AGETSUMA
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# enable debuginfo repo
file "/etc/yum.repos.d/CentOS-Debuginfo.repo" do
  _file = Chef::Util::FileEdit.new(path)
  _file.search_file_replace_line(/enabled=0/, "enabled=1")
  content _file.send(:editor).lines.join
end

# install JDK
include_recipe 'java'

# disable debuginfo repo
file "/etc/yum.repos.d/CentOS-Debuginfo.repo" do
  _file = Chef::Util::FileEdit.new(path)
  _file.search_file_replace_line(/enabled=1/, "enabled=0")
  content _file.send(:editor).lines.join
end
