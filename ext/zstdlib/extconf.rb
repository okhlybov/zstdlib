#!/usr/bin/env ruby

require 'mkmf'
require 'fileutils'

include FileUtils

ZSTD_VERSION = '1.3.8'
ZLIB_VERSION = '1.2.11'
RB_VERSION = Gem.ruby_api_version.slice(/^\d+\.\d+/)

root = File.dirname(__FILE__)

zmod = "#{root}/ruby/zlib-#{RB_VERSION}"
zlib = "#{root}/zlib-#{ZLIB_VERSION}"
zstd = "#{root}/zstd-#{ZSTD_VERSION}/lib"
zlibwrapper = "#{root}/zstd-#{ZSTD_VERSION}/zlibWrapper"

File.open('zstdlib.c', 'w') do |file|
  file << File.read("#{zmod}/zlib.c").
    gsub(/Init_zlib/, 'Init_zstdlib').
    gsub(/rb_define_module.*/, 'rb_define_module("Zstdlib");').
    gsub(%~<zlib.h>~, %~<zstd_zlibwrapper.h>~)
end

$srcs = ['zstdlib.c']

$CFLAGS += ' -O3'
$CPPFLAGS += " -I#{zlibwrapper} -DZWRAP_USE_ZSTD=1 -DGZIP_SUPPORT=0"
$LIBS += ' -lzlibwrapper -lzstd -lz'

create_makefile('zstdlib')

mk = File.read('Makefile')

File.open('Makefile', 'wt') do |file|
  file << mk
  file <<
%~
export CFLAGS CPPFLAGS
$(DLLIB) : libzstd.a libzlibwrapper.a libz.a
libzstd.a :
\tSRCDIR=#{zstd} $(MAKE) -f #{root}/zstd.mk
libz.a :
\tSRCDIR=#{zlib} $(MAKE) -f #{root}/zlib.mk
libzlibwrapper.a :
\tSRCDIR=#{zlibwrapper} $(MAKE) -f #{root}/zlibwrapper.mk
clean-mk:
\tSRCDIR=#{zlib} $(MAKE) -f #{root}/zlib.mk clean
\tSRCDIR=#{zstd} $(MAKE) -f #{root}/zstd.mk clean
\tSRCDIR=#{zlibwrapper} $(MAKE) -f #{root}/zlibwrapper.mk clean
~
end