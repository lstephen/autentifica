#!/bin/bash

curl -sSL https://get.docker.com/ubuntu/ | sudo sh

mkdir -p /usr/local/bin

curl -L https://github.com/docker/fig/releases/download/1.0.1/fig-`uname -s`-`uname -m` > /usr/local/bin/fig; chmod +x /usr/local/bin/fig
