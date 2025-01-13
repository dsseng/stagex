#!/bin/sh
set -eu

env -C out/$1 tar -c . | docker load
docker tag stagex/$1:$2 ghcr.io/dsseng/stagex-$1:$2
docker push ghcr.io/dsseng/stagex-$1:$2
