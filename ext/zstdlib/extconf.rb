#!/usr/bin/env ruby

require 'mkmf'
require 'fileutils'

include FileUtils

ZSTD_VERSION = '1.3.8'
RB_VERSION = Gem.ruby_api_version

root = File.dirname(__FILE__)

zlib = "#{root}/zlib-#{RB_VERSION}"
zstd = "#{root}/zstd-#{ZSTD_VERSION}/lib"
zlibwrapper = "#{root}/zstd-#{ZSTD_VERSION}/zlibWrapper"

File.open('zstdlib.c', 'w') do |file|
  file << File.read("#{zlib}/zlib.c").
    gsub(/Init_zlib/, 'Init_zstdlib').
    gsub(/rb_define_module.*/, 'rb_define_module("Zstdlib");').
    gsub(/<zlib.h>/, '<zstd_zlibwrapper.h>')
end

$CFLAGS += ' -O3'
$CPPFLAGS += " -I#{zlibwrapper} -DZWRAP_USE_ZSTD=1 -DGZIP_SUPPORT=0"

eval File.read("#{zlib}/extconf.rb").gsub(/'zlib'/, %~'zstdlib'~)

mk = File.read('Makefile').
  gsub(/^\s*LIBS\s*=(.*)/, 'LIBS = -lzlibwrapper -lzstd \1').
  gsub(/^(\s*clean\s*:.*)/, '\1 clean-mk')

File.open('Makefile', 'wt') do |file|
  file << mk
  file <<
%~
export CFLAGS CPPFLAGS
$(DLLIB) : libzstd.a libzlibwrapper.a
libzstd.a :
\tSRCDIR=#{zstd} $(MAKE) -f #{root}/zstd.mk
libzlibwrapper.a :
\tSRCDIR=#{zlibwrapper} $(MAKE) -f #{root}/zlibwrapper.mk
clean-mk:
\tSRCDIR=#{zstd} $(MAKE) -f #{root}/zstd.mk clean
\tSRCDIR=#{zlibwrapper} $(MAKE) -f #{root}/zlibwrapper.mk clean
~
end