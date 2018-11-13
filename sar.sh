#!/usr/bin/env sh
while /bin/true; do
  out=$(sar 1 1)
  echo "$out" > /var/tmp/sar
done
