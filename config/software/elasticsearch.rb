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

name "elasticsearch"
version "0.90.0"

dependency "jre"
dependency "rsync"


source :url => "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.0.tar.gz",
       :md5 => "a9656afbde7c2c516cab0588bb9c1f03"

relative_path "elasticsearch-0.90.0"

build do
  command "#{install_dir}/embedded/bin/rsync -a . #{install_dir}/embedded/elasticsearch/"
  # delete solaris libraries that break omnibus library checking.
  # if you use solaris comment out next two lines, and may God have mercy on your soul.
  command "rm -f #{install_dir}/embedded/elasticsearch/lib/sigar/libsigar-x86-solaris.so"
  command "rm -f #{install_dir}/embedded/elasticsearch/lib/sigar/libsigar-amd64-solaris.so"
  command "#{install_dir}/embedded/elasticsearch/bin/plugin -install elasticsearch/elasticsearch-river-rabbitmq/1.4.0"
  command "#{install_dir}/embedded/elasticsearch/bin/plugin -install lukas-vlcek/bigdesk"
  command "#{install_dir}/embedded/elasticsearch/bin/plugin -install karmi/elasticsearch-paramedic"
  command "#{install_dir}/embedded/elasticsearch/bin/plugin -install mobz/elasticsearch-head"
end
