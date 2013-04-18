#
# Cookbook Name:: pngout
# Recipe:: default
#
# Copyright 2013, Go Try It On, Inc.
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

remote_file "#{Chef::Config[:file_cache_path]}/pngout-#{node[:pngout][:version]}.tar.gz" do
  source "http://static.jonof.id.au/dl/kenutils/pngout-#{node[:pngout][:version]}.tar.gz"
  checksum node[:pngout][:checksum]
  action :create_if_missing
end

bash "install pngout" do
  cwd Chef::Config[:file_cache_path]
  user "root"
  code <<-EOH
    mkdir -p pngout-#{node[:pngout][:version]} && \
    cd pngout-#{node[:pngout][:version]} && \
    tar xf ../pngout-#{node[:pngout][:version]}.tar.gz --strip-components=1 && \
    cp i686/pngout* /usr/local/bin/pngout && \
    cd ..
    rm -r pngout-#{node[:pngout][:version]}
  EOH
  not_if "which pngout"
end
