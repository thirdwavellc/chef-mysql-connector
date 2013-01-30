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

bash "Stopping Tomcat" do
	code "sudo bash /opt/liferay/tomcat/bin/shutdown.sh"
end

remote_file "/tmp/#{node['connector']['download_version']}.zip" do
	source node['connector']['download_url']
	action :create_if_missing
end

bash "Extract mysql-connector-j" do
	cwd "/tmp"
	code "sudo unzip /tmp/#{node['connector']['download_version']}.zip"
	action :run
end

bash "Install mysql-connector-j" do
	code "cp /tmp/#{node['connector']['download_version']}/#{node['connector']['download_version']}-bin.jar /opt/liferay/tomcat/lib/ext"
end

bash "Restarting Tomcat" do
	code "sudo bash /opt/liferay/tomcat/bin/startup.sh"
end