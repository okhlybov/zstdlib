#!/usr/bin/env ruby

require 'mkmf'
require 'rbconfig'
require 'fileutils'

include RbConfig
include FileUtils

ZSTD_VERSION = '1.3.8'
RB_VERSION = Gem.ruby_api_version

zlib = "zlib-#{RB_VERSION}"
zstd = "zstd-#{ZSTD_VERSION}/lib"
zlibwrapper = "zstd-#{ZSTD_VERSION}/zlibWrapper"

File.open('zstdlib.c', 'w') do |file|
  file << File.read("#{zlib}/zlib.c").
    gsub(/Init_zlib/, 'Init_zstdlib').
    gsub(/rb_define_module.*/, 'rb_define_module("Zstdlib");').
    gsub(/<zlib.h>/, '<zstd_zlibwrapper.h>')
end

$CFLAGS += ' -O3'
$CPPFLAGS += " -I#{zlibwrapper} -DZWRAP_USE_ZSTD=1 -DGZIP_SUPPORT=0"

load "#{zlib}/extconf.rb"

mk = File.read('Makefile').
  gsub(/^\s*LIBS\s*=(.*)/, 'LIBS = -lzlibwrapper -lzstd \1').
  gsub(/^\s*(TARGET(_NAME)?\s*=).*/, '\1 zstdlib').
  gsub(/^(\s*clean\s*:.*)/, '\1 clean-mk')

File.open('Makefile', 'wt') do |file|
  file << mk
  file <<
%~
export CFLAGS CPPFLAGS
$(DLLIB) : libzstd.a libzlibwrapper.a
libzstd.a :
\tSRCDIR=#{zstd} $(MAKE) -f zstd.mk
libzlibwrapper.a :
\tSRCDIR=#{zlibwrapper} $(MAKE) -f zlibwrapper.mk
clean-mk:
\tSRCDIR=#{zstd} $(MAKE) -f zstd.mk clean
\tSRCDIR=#{zlibwrapper} $(MAKE) -f zlibwrapper.mk clean
~
end