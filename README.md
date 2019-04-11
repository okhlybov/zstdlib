# [Zstdlib](https://bitbucket.org/fougas/zstdlib) - a Zstd (de)compression library binding for Ruby

_zstdlib_ is native Ruby extension for [Zstandard](https://facebook.github.io/zstd/) data compression library.

_zstdlib_ currently supports the [MRI Ruby](https://www.ruby-lang.org/) platform.

## Why bother?

Unlike the other Zstd bindings available for Ruby, `Zstdlib` utilizes Zstd's native `Zlib` compatibility layer. 

This specifically means that `Zstdlib` module is and will be (mostly)  API-compatible with standard Ruby `Zlib` module and thus _zstdlib_ can be used as a drop-in replacement for _zlib_: just replace `Zlib` with `Zstdlib` throughout the source code and you're in!

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

## Technical notes

_zstdlib_ covers the following parts of _zlib_:

- `ZStream`, `Inflate` and `Deflate` classes
- Various `Zlib::` constants (`DEFAULT_COMPRESSION` etc.)
- `Zlib::` exception classes (`Error` and its descendants)

Note that _zstdlib_ currently omits Gzip file support with its `GzipFile`, `GzipReader` and `GzipWriter` classes
and associated constants although this may be changed in future.

### General guidelines

In order to enable Zstd (de)compression capability in existing code, simply replace _zlib_ with _zstdlib_ in require statements and
`Zlib` with `Zstdlib` module references throughout the code.

The rest of the _zlib_-aware code should work unchanged.

For further information refer to documentation on _zlib_ .
                                            

### Notes on compression levels

Contrary to _zlib_ the `NO_COMPRESSION` constant in _zstdlib_ is an equivalent to `BEST_SPEED` as _zstd_ always compresses data.

If unsure do not pass anything to constructor in order to use `DEFAULT_COMPRESSION` level which works for both _zlib_ ans _zstdlib_.

The `BEST_COMPRESSION` constant is adjusted to reflect Zstd-specific compression level range.
Anyway this level is recommended against due to abysmal performance not to be expected from *fast* state-of-the art compression method. 
Zstd documentation recommends using 19 as the level for optimal *best* compression.

The `BEST_SPEED` constant remains unchanged.

## Release history

For user-visible changes refer to [change log](CHANGES.md).


## Availability

_zstdlib_ home page on [bitbucket.org](https://bitbucket.org/fougas/zstdlib).

Source code and Windows-specific multi-versioned binary gems can be obtained from [rubygems.org](https://rubygems.org/gems/zstdlib).

## The end

Cheers,

Oleg A. Khlybov <fougas@mail.ru>
