#!/bin/bash

curl -sSL https://get.docker.com/ubuntu/ | sudo sh

docker -d -H unix://usr/local/share/docker.sock

export DOCKET_HOST=http+unix://usr/local/share/docker.sock

mkdir -p /usr/local/bin

curl -L https://github.com/docker/fig/releases/download/1.0.1/fig-`uname -s`-`uname -m` > /usr/local/bin/fig; chmod +x /usr/local/bin/fig
