begin
  RUBY_VERSION =~ /(\d+\.\d+)/
  require "#{$1}/zstdlib.so"
rescue LoadError
  require 'zstdlib.so'
end