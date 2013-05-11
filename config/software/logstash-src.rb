#
# Copyright:: Copyright (c) 2012 Opscode, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name "logstash-src"
version "v1.1.12"

dependency "jre"
dependency "jruby"

source :git => "https://github.com/logstash/logstash.git"

relative_path "logstash"

build do
  command "mkdir -p #{install_dir}/log"
  command "mkdir -p #{install_dir}/etc/logstash.d"
  command "mkdir -p #{install_dir}/data"
  command "mkdir -p #{install_dir}/patterns"
  command "mkdir -p #{install_dir}/tmp"
  command "mkdir -p #{install_dir}/service"
  command "mkdir -p #{install_dir}/lib"
  command "mkdir -p #{install_dir}/vendor"
#  command "cp logstash-flatjar.jar #{install_dir}/bin/logstash.jar"
  command "#{install_dir}/embedded/bin/rsync -a bin/. #{install_dir}/bin/"
  command "#{install_dir}/embedded/bin/rsync -a etc/. #{install_dir}/etc/"
  command "#{install_dir}/embedded/bin/rsync -a patterns/. #{install_dir}/patterns/"
  command "#{install_dir}/embedded/bin/rsync -a vendor/. #{install_dir}/vendor/"
end