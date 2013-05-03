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

name "jruby"
version "1.7.3"

#dependency "ruby"
#dependency "rubygems"
#dependency "bundler"
dependency "rsync"
dependency "jre"

source :url => "http://jruby.org.s3.amazonaws.com/downloads/1.7.3/jruby-bin-1.7.3.tar.gz",
       :md5 => "f0adf8ccee6f6777f7ab8e5e1d7a1f47"


relative_path "jruby-1.7.3"



build do
  command "#{install_dir}/embedded/bin/rsync -a . #{install_dir}/embedded/jruby/"
end