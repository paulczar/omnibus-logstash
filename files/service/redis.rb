#!/opt/logstash/embedded/bin/ruby

require 'rubygems'
require 'daemons'
require 'pathname'
require 'fileutils'

# Get the full path to this script's directory since Daemons does a chdir to
# / just after forking..
scriptdir = "/opt/logstash/embedded"

# populate environment variables
pid_dir = "/opt/logstash/tmp"
app_name = "redis-server"
log_output = true
log_dir = "/opt/logstash/log"
cmd = "/opt/logstash/embedded/bin/redis-server /opt/logstash/etc/redis.conf"

options = {
          :dir_mode => :normal,
          :dir => pid_dir,
          :log_output => log_output,
          :log_dir => log_dir
          }

Daemons.run_proc(app_name, options) do
  Dir.chdir(scriptdir)
  exec "#{cmd}"
end