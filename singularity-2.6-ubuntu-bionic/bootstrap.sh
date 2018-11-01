#!/usr/bin/env bash

apt-get update && apt-get -y dist-upgrade
apt-get -y install python dh-autoreconf build-essential libarchive-dev

VER=2.6.0
cd /tmp
wget https://github.com/singularityware/singularity/releases/download/$VER/singularity-$VER.tar.gz
tar xvf singularity-$VER.tar.gz
cd singularity-$VER
./configure && make && make install 

cp etc/bash_completion.d/singularity /etc/bash_completion.d/
