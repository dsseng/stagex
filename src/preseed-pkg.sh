#!/bin/sh
set -eu

docker pull $2
rm -rf "out/$1"
mkdir -p "out/$1"
docker save $2 | tar -xC out/$1