# Zstdlib - a Zstd (de)compression library binding for Ruby

Zstdlib is meant to be a drop-in replacement for the standard Ruby `zlib` module.

## Why bother?

Just replace `Zlib` with `Zstdlib` in the source code and you're in.

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
data = ''
````

## Release history

For user-visible changes refer to [change log](CHANGES.md).