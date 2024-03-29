# [Zstdlib](https://github.com/okhlybov/zstdlib) - a Zstandard data compression library binding for Ruby

_zstdlib_ is native Ruby extension for [Zstandard](https://facebook.github.io/zstd/) data compression library.

_zstdlib_ is currently available for the [MRI Ruby](https://www.ruby-lang.org/) platform.

## Why bother?

Unlike the other Zstd bindings available for Ruby, *Zstdlib* utilizes Zstd's native *Zlib* compatibility layer. 

This specifically means that `Zstdlib` module is and will be (mostly)  API-compatible with standard Ruby `Zlib` module and thus _zstdlib_ can be used as a drop-in replacement for _zlib_: just replace `Zlib` with `Zstdlib` throughout the source code and you're in!

Streams produced by `Zstdlib::Deflate` class can be decompressed with standard _zstd_ utility and hence can be written to _.zst_ or _.zstd_ files.
Conversely, the `Zstdlib::Inflate` class can handle data from such files.

## Use cases

### Simple string compression
````ruby
require 'zstdlib'
data = Zstdlib.deflate('Hello Zstd')
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

### Simple string decompression
````ruby
require 'zstdlib'
data = Zstdlib.inflate(compressed_data)
````

## Technical notes

_zstdlib_ covers the following parts of _zlib_:

- `ZStream`, `Inflate` and `Deflate` classes
- Various `Zlib::` constants (`DEFAULT_COMPRESSION` etc.)
- `Zlib::` exception classes (`Error` and its descendants)

Note that _zstdlib_ currently omits Gzip file support with its `GzipFile`, `GzipReader` and `GzipWriter` classes
and associated constants although this may be changed in future.

There exist `Zstdlib::ZSTD_VERSION` constant and `Zstdlib.zstd_version` module method which can be used to obtain shipped Zstd library version.


### General guidelines

In order to enable Zstd (de)compression capability in existing code, simply replace _zlib_ with _zstdlib_ in require statements and
`Zlib` with `Zstdlib` module references throughout the code.

The rest of the _zlib_-aware code should work unchanged.

For further information refer to documentation on _zlib_ .
                                            

### Notes on compression levels

If unsure do not pass anything to constructor in order to use `DEFAULT_COMPRESSION` level which works for both _zlib_ ans _zstdlib_.

Contrary to _zlib_ the `NO_COMPRESSION` constant in _zstdlib_ is an equivalent to `BEST_SPEED` as Zstd always compresses data.

The `BEST_COMPRESSION` constant is adjusted to reflect Zstd-specific compression level range.
Anyways this level is recommended against due to abysmal performance not to be expected from the *fast* state-of-the-art compression algorithm. 
The Zstd documentation (currently) recommends using *19* as the level for optimal *best* compression.

The `BEST_SPEED` constant remains unchanged.

## Availability

_zstdlib_ home page on [GitHub](https://github.com/okhlybov/zstdlib).

Source code and system-specific compiled gems can be obtained from [rubygems.org](https://rubygems.org/gems/zstdlib).

The system-specific gems are currently provided for x32/x64 Windows and x64/ARM64 MacOS platforms.

Note that these gems are built with the [rake-compiler-dock](https://github.com/rake-compiler/rake-compiler-dock)
infrastructure the minimum supported Ruby version is raised to 2.4.
All other installations including Linux will use the source gem and hence require the compilation step with locally installed development tools.

## Release history

For user-visible changes refer to [change log](CHANGES.md).

## Caveats

This module is in testing phase so things beyond basic interface might not work as expected. 

Documentation extracted from _zstdlib_ still contains traces of old zlib-related pieces.
Just keep this in mind and substitute *zlib* with *zstdlib* upon browsing.

Gzip _.gz_ file support, although available in Zstd's Zlib compatibility layer, is currently disabled.

Zstd's external compression dictionaries capability is not (yet) implemented.

# The end

Cheers,

Oleg A. Khlybov <[fougas@mail.ru](mailto:fougas@mail.ru)>
