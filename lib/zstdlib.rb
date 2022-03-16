begin
  RUBY_VERSION =~ /(\d+\.\d+)/
  require "#{$1}/zstdlib_c"
rescue LoadError
  require 'zstdlib_c'
end