begin
  RUBY_VERSION =~ /(\d+\.\d+)/
  require "#{$1}/zstdlib"
rescue LoadError
  require 'zstdlib'
end