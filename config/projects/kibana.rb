
name "logstash"
maintainer "Paul Czarkowski"
homepage "http://tech.paulcz.net"

replaces        "kibana"
install_path    "/opt/kibana"
build_version   Omnibus::BuildVersion.new.semver
build_iteration 1

# creates required build directories
dependency "preparation"

# logstash dependencies/components
dependency "kibana"

# version manifest file
dependency "version-manifest"

exclude "\.git*"
exclude "bundler\/git"
