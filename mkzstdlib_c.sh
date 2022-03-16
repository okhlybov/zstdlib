#!/bin/bash

# Convert all exesting Ruby module sources zlib.c to zstdlib.c

for zlib in `find ext/zstdlib_c/ruby -name zlib.c`; do
  zstdlib=`dirname $zlib`/zstdlib.c
  echo $zstdlib
  cat $zlib | sed -f zstdlib_c.sed > $zstdlib
done

#