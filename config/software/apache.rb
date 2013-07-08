#
# Copyright:: Copyright (c) 2012 Opscode, Inc.
# License:: Apache License, Version 2.0
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

name "apache"
version "2.4.4"

dependency "autoconf"
dependency "automake"
dependency "libtool"
dependency "openssl"

source :url => "http://mirror.symnds.com/software/Apache//httpd/httpd-2.4.4.tar.gz",
       :md5 => "a2fed766e67c9681e0d9b86768f08286"

relative_path "apache-2.4.4"

reconf_env = {"PATH" => "#{install_dir}/embedded/bin:#{ENV["PATH"]}"}

configure_env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include -L/lib -L/usr/lib",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
  "PATH" => "#{install_dir}/embedded/bin:#{ENV["PATH"]}"
}

build do
 
  # configure and build
  command "./configure --prefix=#{install_dir}/embedded  --with-included-apr --with-mpm=worker --enable-deflate --enable-mime-magic \
    --enable-proxy --enable-ssl --with-ssl=#{install_dir}/embedded/bin --disable-status --enable-vhost-alias --disable-cgid --disable-userdir --enable-rewrite \
    --enable-mods-shared='isapi file_cache cache disk_cache mem_cache ext_filter expires headers usertrack unique_id status info cgi cgid speling' ", :env => configure_env
  command "make -j #{max_build_jobs}", :env => {"LD_RUN_PATH" => "#{install_dir}/embedded/lib"}
  command "make install"
end
