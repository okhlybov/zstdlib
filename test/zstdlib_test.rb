require 'test/unit'
require 'zstdlib'

class ZstdlibTest < Test::Unit::TestCase


  def test_simple
    hello = %~Hello, Zstd!~
    assert_equal Zstdlib.inflate(Zstdlib.deflate(hello)), hello
  end

  def test_incremental_compress_simple
    out = String.new
    parts = %w[123 456 789]
    zstd = Zstdlib::Deflate.new
    parts.each {|p| out << zstd.deflate(p)}
    out << zstd.finish
    assert_equal Zstdlib.inflate(out), parts.join
  end

end