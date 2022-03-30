#!/usr/bin/env ruby

# Clean up zlib sources retaining only the files required to build Ruby extension in order to reduce gem size.

require 'fileutils'
include FileUtils

Dir["zlib-*"].each do |d|
  cd d do
    dirs = Dir["**/**"].select {|d| File.directory?(d)}
    dirs.each {|d| remove_dir(d, true)}
    files = Dir["**/*"].reject {|f| File.directory?(f) || /\.[ch]$/ =~ f}
    files.each {|f| rm_f(f)}
  end
end