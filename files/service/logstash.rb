#!/opt/logstash/embedded/bin/ruby

require 'rubygems'
require 'daemons'
require 'pathname'
require 'fileutils'

# Get the full path to this script's directory since Daemons does a chdir to
# / just after forking..
scriptdir = "/opt/logstash/"

# some variables to make things easier to remember

CONFIG_DIR   = "/opt/logstash/etc/logstash.d"
ARGS         = "agent --config #{CONFIG_DIR}"

# new command will look something like below.
# GEM_HOME=/opt/logstash/vendor/bundle/jruby/1.9/ USE_JRUBY=1 PATH=$PATH:/opt/logstash/embedded/jre/bin bin/logstash agent  -e 'input{stdin{type=>"test"}} output {stdout{}}'


# populate environment variables
pid_dir = "/opt/logstash/tmp"
app_name = "logstash"
log_output = true
log_dir = "/opt/logstash/log"
cmd = "/opt/logstash/bin/logstash-omnibus #{ARGS}"

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
