#
# Cookbook Name:: mysql-connector
# Recipe:: java
#
# Copyright 2013, Thirdwave, LLC
# Authors:
# 		Adam Krone <adam.krone@thirdwavellc.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

remote_file "/tmp/#{node['connector']['version']}.zip" do
	source node['connector']['download_url']
	action :create_if_missing
end

bash "Extract mysql-connector-j" do
	command "sudo unzip /tmp/#{node['connector']['version']}"
	action :run
end

bash "Install mysql-connector-j" do
	command "cp /tmp/#{node['connector']['version']}/#{node['connector']['version']}-bin.jar $CATALINA_HOME/lib/#{node['connector']['version']}/#{node['connector']['version']}-bin.jar"
end