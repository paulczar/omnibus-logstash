
name "logstash"
maintainer "Paul Czarkowski"
homepage "http://tech.paulcz.net"

replaces        "logstash"
install_path    "/opt/logstash"
build_version   Omnibus::BuildVersion.new.semver
build_iteration 1

# creates required build directories
dependency "preparation"

# logstash dependencies/components
dependency "logstash"
dependency "kibana"
dependency "kibana3"
dependency "elasticsearch"
dependency "redis"
dependency "logstash-extras"

#dependency "rabbitmq"
# rabbit relies on broken erlang package.

# version manifest file
dependency "version-manifest"

exclude "\.git*"
exclude "bundler\/git"
