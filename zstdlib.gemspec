Gem::Specification.new do |spec|
  spec.name          = 'zstdlib'
  spec.version       = '0.4.0'
  spec.authors       = ['Oleg A. Khlybov']
  spec.email         = ['fougas@mail.ru']
  spec.summary       = %q{Ruby interface for the Zstd data compression library}
  spec.description   = %q{A Zlib drop-in replacement implementing Zstandard compression algorithm}
  spec.homepage      = 'https://github.com/okhlybov/zstdlib'
  spec.license       = 'BSD-3-Clause'
  spec.files         = (
    %w(Rakefile Gemfile .yardopts) +
    %w(*.md lib/*.rb test/*.rb).collect {|glob| Dir[glob]} +
    %w(ruby/**/zstdlib.c zstd*/**/*.[ch] zlib*/**/*.[ch] zlib*/**/extconf.rb *.mk).collect {|glob| Dir['ext/zstdlib/' << glob]}
  ).flatten
  spec.extensions    = 'ext/zstdlib/extconf.rb'
  spec.platform      = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.2.0'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rake-compiler'
  spec.add_development_dependency 'rake-compiler-dock', '~> 0.7.2'
  spec.add_development_dependency 'test-unit'
end
