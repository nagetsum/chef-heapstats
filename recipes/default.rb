#
# Cookbook Name:: heapstats
# Recipe:: default
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

# check platform
if !(platform?("centos","fedora"))
  Chef::Application.fatal! "this cookbook is currently only support centos or fedora"
end

# install jdk with debuginfo
if platform?("centos") 
  include_recipe "heapstats::java_centos"
end

if platform?("fedora")
  include_recipe "heapstats::java_fedora"
end

# install heapstats dependencies
%w{pcre net-snmp-libs}.each do |pkg|
  package pkg do
    action :install
  end
end

# install heapstats agent
include_recipe "heapstats::heapstats"
