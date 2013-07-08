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
version "v1.1.13"

dependency "jre"
#dependency "jruby"

source :git => "https://github.com/logstash/logstash.git"

relative_path "logstash"

cwd = "/var/cache/omnibus/src/logstash"

env = {
  "JAVA_HOME" => "#{install_dir}/embedded/jre",
  "GEM_HOME" => "#{install_dir}/vendor/bundle/jruby/1.9/",
  "PATH" => "/opt/logstash/embedded/jre/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:"
}


build do
  command "mkdir -p #{install_dir}/log"
  command "mkdir -p #{install_dir}/etc/logstash.d"
  command "mkdir -p #{install_dir}/data"
  command "mkdir -p #{install_dir}/patterns"
  command "mkdir -p #{install_dir}/tmp"
  command "mkdir -p #{install_dir}/service"
  command "mkdir -p #{install_dir}/lib"
  command "mkdir -p #{install_dir}/vendor"
  command "mkdir -p #{install_dir}/locales"
#  bundle "install"
  #command "#{install_dir}/embedded/jruby/bin/jruby #{install_dir}/embedded/jruby/bin/jgem install bundler", :env => env
  #command "#{install_dir}/embedded/jruby/bin/jruby #{install_dir}/embedded/jruby/bin/bundle install", :env => env
  #command "make vendor-elasticsearch", :env => env
  #command "#{install_dir}/embedded/jruby/bin/jruby ./gembag.rb logstash.gemspec", :env => env
  command "make build-jruby", :env => env
  #command "su - root -c /tmp/runme.sh", :env => env
  command "su - root -c \"cd /opt/logstash; JAVA_HOME=#{install_dir}/embedded/jre GEM_HOME=#{install_dir}/vendor/bundle/jruby/1.9/ #{install_dir}/embedded/jre/bin/java -jar #{cwd}/vendor/jar/jruby-complete-1.7.3.jar #{cwd}/gembag.rb #{cwd}/logstash.gemspec\"", :env => env
  #command "make vendor-gems 2>> /tmp/errors.txt >> /tmp/output.txt", :env => env
  command "#{install_dir}/embedded/bin/rsync -a bin/. #{install_dir}/bin/"
  command "#{install_dir}/embedded/bin/rsync -a vendor/. #{install_dir}/vendor/"
  command "#{install_dir}/embedded/bin/rsync -a etc/. #{install_dir}/etc/"
  command "#{install_dir}/embedded/bin/rsync -a patterns/. #{install_dir}/patterns/"
  #command "#{install_dir}/embedded/bin/rsync -a vendor/. #{install_dir}/vendor/"
  command "#{install_dir}/embedded/bin/rsync -a lib/. #{install_dir}/lib/"
  command "#{install_dir}/embedded/bin/rsync -a locales/. #{install_dir}/locales/"
end
