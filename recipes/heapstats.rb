#
# Cookbook Name:: heapstats
# Recipe:: heapstats
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

# Download HeapStats agent
heapstats_url = node[:heapstats][:heapstatsurl]
version = node[:heapstats][:version]
build = node[:heapstats][:build]
arch = node[:kernel][:machine]

# binaly install support only rhel or fedora
platform = value_for_platform_family(
  "rhel"   => "el6",
  "fedora" => "fc20"
)

# support sse4 or avx ?
# if both are supported, avx preferentially
cpuflags = node[:cpu]['0'][:flags]
rpm_file = 
case cpuflags
when cpuflags.include?("sse4") && !cpuflags.include?("avx") then
  "heapstats_agent-#{version}-#{build}.sse4.#{platform}.#{arch}.rpm"
when cpuflags.include?("avx") then
  "heapstats_agent-#{version}-#{build}.avx.#{platform}.#{arch}.rpm"
else
  "heapstats_agent-#{version}-#{build}.#{platform}.#{arch}.rpm"
end 

remote_file "#{Chef::Config[:file_cache_path]}/#{rpm_file}" do
  source "#{heapstats_url}/heapstats-#{version}/bin/agent/#{platform}/#{arch}/#{rpm_file}"
end

# install HeapStats agent
package "heapstats_agent" do
  action :install
  source "#{Chef::Config[:file_cache_path]}/#{rpm_file}"
end

# template heapstats.conf
template "/etc/heapstats/heapstats.conf" do
  owner "root"
  group "root"
  mode  0644
end
