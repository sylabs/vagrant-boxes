#!/usr/bin/env bash

SING_VERSION="v3.0.1"

apt-get update && apt-get -y dist-upgrade
apt-get install -y build-essential libssl-dev uuid-dev libgpgme11-dev

export VERSION=1.11 OS=linux ARCH=amd64
cd /tmp
wget https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz
tar -C /usr/local -xzf go$VERSION.$OS-$ARCH.tar.gz

echo 'export GOPATH=${HOME}/go' >> ~/.bashrc
echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin' >> ~/.bashrc
export GOPATH=${HOME}/go
export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin

mkdir -p $GOPATH/src/github.com/sylabs
cd $GOPATH/src/github.com/sylabs
git clone https://github.com/sylabs/singularity.git
git fetch
git checkout ${SING_VERSION}
cd singularity

go get -u github.com/golang/dep/cmd/dep
./mconfig
cd ./builddir
make && sudo make install 

cp etc/bash_completion.d/singularity /etc/bash_completion.d/
