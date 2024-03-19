#!/usr/bin/env sh
if [ -x "$(command -v nproc)" ]; then
  make -j$(nproc --ignore=2) $@ # ignore 2 threads so that computer isn't unresponsive
else
  make -j$(sysctl -n hw.logicalcpu) $@ # nproc doesn't exist on macos and this doesn't work on linux
fi
