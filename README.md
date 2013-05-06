# logstash Omnibus project

This project creates full-stack platform-specific packages for
`logstash`!

It installs the following apps and the support libraries and start/stop scripts for

* logstash
* elasticsearch
* redis
* kibana
* kibana3
* rabbitmq ( not working yet, need to work through erlang issues )

Start  - `/opt/logstash/bin/start`
Status - `/opt/logstash/bin/status`
Stop   - `/opt/logstash/bin/stop`

Kibana        - http://localhost:5601
Kibana3       - http://localhost:8000/index.html
Elasticsearch - http://localhost:9200/_status?pretty=true
BigDesk       - http://localhost:9200/_plugin/bigdesk/
Head          - http://localhost:9200/_plugin/head/

config files all found in `/opt/logstash/etc`
individual init scripts found in `/opt/logstash/service`

* read local syslog files,
* listen to TCP:514 for syslog messages, 
* subscribe to local redis server,
* attempt to parse syslog messages,
* output to elasticsearch  

# Using the logstash omnibus packages

I have prebuilt some Packages which can be found here -

## RHEL 6.x  64bit

    https://s3-us-west-2.amazonaws.com/paulcz-packages/logstash-omnibus-1.1.10.el6.x86_64.rpm
    rpm -Uhv logstash-omnibus.rpm

## Ubuntu 12.04 64bit

    wget https://s3-us-west-2.amazonaws.com/paulcz-packages/logstash-omnibus-1.1.10_amd64.deb
    deb -i logstash-omnibus.deb

## Start Processes

    sudo /opt/logstash/bin/start

## Send some fake logs

via netcat

    echo `date +"%b %e %T"` `hostname` foo[666]: some random text | nc localhost 514

or if you don't have netcat installed

    echo `date +"%b %e %T"` `hostname` foo[666]: some random text >> /var/log/syslog

## Search your logs

open your web browser and browse to 

Kibana        - http://localhost:5601
or
Kibana3       - http://localhost:8000/index.html


# Building the logstash omnibus packages

## Installation

We'll assume you have Ruby 1.9+ and Bundler installed. First ensure all
required gems are installed and ready to use:

    bundle install --binstubs

## Usage

### Build

_ubuntu 12.x + bugfix_

    sudo apt-get -y install libncurses5-dev

You create a platform-specific package using the `build project` command:

    bin/omnibus build project logstash

The platform/architecture type of the package created will match the platform
where the `build project` command is invoked. So running this command on say a
MacBook Pro will generate a Mac OS X specific package. After the build
completes packages will be available in `pkg/`.

builds and installs into /opt/logstash

* logstash
* kibana
* redis
* elasticsearch
* jre
* ruby
* jruby
* a bunch of dependencies


### Clean

You can clean up all temporary files generated during the build process with
the `clean` command:

    bin/omnibus clean


Adding the `--purge` purge option removes __ALL__ files generated during the
build including the project install directory (`/opt/logstash`) and
the package cache directory (`/var/cache/omnibus/pkg`):

    bin/omnibus clean --purge

### Help

Full help for the Omnibus command line interface can be accessed with the
`help` command:

    bin/omnibus help

## Vagrant-based Virtualized Build Lab

Every Omnibus project ships will a project-specific
[Berksfile](http://berkshelf.com/) and [Vagrantfile](http://www.vagrantup.com/)
that will allow you to build your projects on the following platforms:

* CentOS 5 64-bit
* CentOS 6 64-bit
* Ubuntu 10.04 64-bit
* Ubuntu 11.04 64-bit
* Ubuntu 12.04 64-bit

Please note this build-lab is only meant to get you up and running quickly;
there's nothing inherent in Omnibus that restricts you to just building CentOS
or Ubuntu packages. See the Vagrantfile to add new platforms to your build lab.

The only requirements for standing up this virtualized build lab are:

* VirtualBox - native packages exist for most platforms and can be downloaded
from the [VirtualBox downloads page](https://www.virtualbox.org/wiki/Downloads).
* Vagrant 1.2.1+ - native packages exist for most platforms and can be downloaded
from the [Vagrant downloads page](http://downloads.vagrantup.com/).

The [vagrant-berkshelf](https://github.com/RiotGames/vagrant-berkshelf) and
[vagrant-omnibus](https://github.com/schisamo/vagrant-omnibus) Vagrant plugins
are also required and can be installed easily with the following commands:

```shell
$ vagrant plugin install vagrant-berkshelf
$ vagrant plugin install vagrant-omnibus
```

Once the pre-requisites are installed you can build your package across all
platforms with the following command:

```shell
$ vagrant up
```

If you would like to build a package for a single platform the command looks like this:

```shell
$ vagrant up PLATFORM
```

The complete list of valid platform names can be viewed with the
`vagrant status` command.


## ToDo

* build control/init scripts
* default configs for all parts so they can run
* /opt/logstash/etc to hold both above
* central log dir for all packages

## Misc

* I had to patch libiconv.rb to build on my system for ruby.  I did it dirty, then found this, so used it instead.  https://github.com/opscode/omnibus-software/pull/14/files.   Opscode please take his pull request.
* erlang fails which means I couldn't build rabbit in.
