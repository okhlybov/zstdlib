Gem::Specification.new do |spec|
  spec.name          = 'zstdlib'
  spec.version       = '0.1.0'
  spec.authors       = ['Oleg A. Khlybov']
  spec.email         = ['fougas@mail.ru']
  spec.summary       = %q{Ruby interface for the zstd (de)compression library}
  spec.description   = %q{Drop-in replacement for standard zlib module which allows to use zstd (de)compression}
  spec.homepage      = 'https://bitbucket.org/fougas/zstdlib'
  spec.license       = 'BSD-3-Clause'
  spec.files         = [__FILE__] + Dir['**/*.[ch]'] + Dir['**/*.rb'] + Dir['**/*.mk']
  spec.extensions    = 'ext/zstdlib/extconf.rb'
  spec.required_ruby_version = '>= 2.2.0'
end