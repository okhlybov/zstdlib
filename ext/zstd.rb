#!/usr/bin/env ruby

# Clean up zstd sources retaining only the files required to build Ruby extension in order to reduce gem size.

require 'fileutils'
include FileUtils

cd Dir["zstd-*"].first do
  dirs = Dir.glob("**/", File::FNM_DOTMATCH).select {|d| File.directory?(d)}
  dirs -= dirs.select {|d| Regexp.new("^(lib/$|lib/(common|compress|decompress)|zlibWrapper/$)").match(d) && !/example/.match(d)}
  dirs.each {|d| remove_dir(d, true)}
  files = Dir.glob("**/*", File::FNM_DOTMATCH).reject {|f| File.directory?(f) || /\.[ch]$/ =~ f}
  files.each {|f| rm_f(f)}
end