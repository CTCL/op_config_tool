#!/bin/bash
# perform some very rudimentary platform detection (taken from docker install script)
command_exists() {
  command -v "$@" > /dev/null 2>&1
}
lsb_dist=''
dist_version=''
if command_exists lsb_release; then
  lsb_dist="$(lsb_release -si)"
  dist_version="$(lsb_release --codename | cut -f2)"
fi
if [ -z "$lsb_dist" ] && [ -r /etc/lsb-release ]; then
  lsb_dist="$(. /etc/lsb-release && echo "$DISTRIB_ID")"
  dist_version="$(. /etc/lsb-release && echo "$DISTRIB_CODENAME")"
fi
if [ -z "$lsb_dist" ] && [ -r /etc/debian_version ]; then
  lsb_dist='debian'
  dist_version="$(cat /etc/debian_version | sed 's/\/.*//' | sed 's/\..*//')"
  case "$dist_version" in
    8)
      dist_version="jessie"
      ;;

    7)
      dist_version="wheezy"
      ;;
  esac
fi
if [ -z "$lsb_dist" ] && [ -r /etc/fedora-release ]; then
  lsb_dist='fedora'
  dist_version="$(rpm -qa \*-release | cut -d"-" -f3 | head -n1)"
fi
if [ -z "$lsb_dist" ]; then
  if [ -r /etc/centos-release ] || [ -r /etc/redhat-release ]; then
    lsb_dist='centos'
    dist_version="$(rpm -qa \*-release | cut -d"-" -f3 | head -n1)"
  fi
fi
if [ -z "$lsb_dist" ] && [ -r /etc/os-release ]; then
  lsb_dist="$(. /etc/os-release && echo "$ID")"
  dist_version="$(. /etc/os-release && echo "$VERSION_ID")"
fi

lsb_dist="$(echo "$lsb_dist" | tr '[:upper:]' '[:lower:]')"

# install aws
case "$lsb_dist" in
  amzn|fedora|centos)
    yum -y install python-pip
    pip install awscli
    ;;
  ubuntu|debian)
    apt-get update
    apt-get install -y python-pip
    pip install awscli
    ;;
esac

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
chmod 755 $DIR/op_config_tool.py
cat $OPS >> ~/.bashrc <<SETOP
OP_CONFIG_PATH=$DIR
if [ \$PYTHONPATH ]
then
    export PYTHONPATH=:\$PYTHONPATH
fi
export PYTHONPATH=$DIR\$PYTHONPATH
alias opc="$DIR/op_config_tool.py $DIR/op.cfg"
SETOP
