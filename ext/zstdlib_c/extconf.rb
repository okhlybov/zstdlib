#!/usr/bin/env ruby

require 'mkmf'
require 'fileutils'

include RbConfig
include FileUtils

ZSTD_VERSION = '1.5.7'
ZLIB_VERSION = '1.3.1'

RB_VERSION = CONFIG['MAJOR']+'.'+CONFIG['MINOR']

# Review requirements with every new zlib module release!
ZMOD_VERSION =  if    RB_VERSION >= '2.5' then '3.3'
                elsif RB_VERSION >= '2.3' then '3.2'
                else  RB_VERSION
                end

# For cross compiling
ENV['CC'] = RbConfig::CONFIG['CC']
ENV['LD'] = RbConfig::CONFIG['LD']

root = File.dirname(__FILE__)

zmod = File.expand_path "ruby/zlib-#{ZMOD_VERSION}", root
zlib = File.expand_path "zlib-#{ZLIB_VERSION}", root
zstd = File.expand_path "zstd-#{ZSTD_VERSION}/lib", root
zlibwrapper = File.expand_path "zstd-#{ZSTD_VERSION}/zlibWrapper", root

cp "#{zmod}/zstdlib.c", 'zstdlib.c'

$srcs = ['zstdlib.c']

$CFLAGS += ' -fomit-frame-pointer -ffast-math -O3'
$CPPFLAGS += " -I#{zlib} -I#{zlibwrapper} -I#{zstd} -DZWRAP_USE_ZSTD=1 -DGZIP_SUPPORT=1"
$LDFLAGS += ' -s'
$LOCAL_LIBS += ' libzlibwrapper.a libz.a libzstd.a'

create_makefile('zstdlib_c')

File.open('Makefile', 'a') do |file|
file << %~

export CC LD AR CFLAGS CPPFLAGS

$(DLLIB) : libz.a libzstd.a libzlibwrapper.a

libzstd.a :
\texport SRCDIR=#{zstd} && mkdir -p zstd && $(MAKE) -C zstd -f #{File.expand_path root}/zstd.mk

libz.a :
\texport SRCDIR=#{zlib} && mkdir -p zlib && $(MAKE) -C zlib -f #{File.expand_path root}/zlib.mk

libzlibwrapper.a :
\texport SRCDIR=#{zlibwrapper} && mkdir -p zlibwrapper && $(MAKE) -C zlibwrapper -f #{File.expand_path root}/zlibwrapper.mk

~
end
