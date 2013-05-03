
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
# dependency "somedep"

# version manifest file
dependency "version-manifest"
dependency "logstash"
dependency "kibana"
dependency "elasticsearch"
dependency "elasticsearch-servicewrapper"
dependency "redis"
dependency "rabbitmq"

exclude "\.git*"
exclude "bundler\/git"
