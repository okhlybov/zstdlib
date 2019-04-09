# Zstdlib - a Zstd (de)compression library binding for Ruby

_zstdlib_ is meant to be a drop-in replacement for the standard Ruby _zlib_ module.

## Why bother?

Just replace `Zlib` with `Zstdlib` in the source code and you're in.

Streams produced by `Zstdlib::Deflate` can be decompressed with standard _zstd_ utility and hence can be written to _.zst_ or _.zstd_ files.

## Use cases

### Simple string compression
````ruby
require 'zstdlib'
data = Zstdlib.deflate('Hello, Zstd!')
````

### Incremental data compression
````ruby
require 'zstdlib'
zstd = Zstdlib::Deflate.new
data = String.new
data << zstd.deflate('Hello')
data << zstd.deflate('Zstd')
data << zstd.finish
````

### Notes on compression levels

Contrary to _zlib_ the `NO_COMPRESSION` constant in _zstdlib_ is an equivalent to `BEST_SPEED` as _zstd_ always compresses data.

If unsure do not pass anything to constructor in order to use `DEFAULT_COMPRESSION` level which works for both _zlib_ ans _zstdlib_.
 
## Release history

For user-visible changes refer to [change log](CHANGES.md).