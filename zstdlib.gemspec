Gem::Specification.new do |spec|
  spec.name          = 'zstdlib'
  spec.version       = '0.1.0'
  spec.authors       = ['Oleg A. Khlybov']
  spec.email         = ['fougas@mail.ru']
  spec.summary       = %q{Ruby interface for the Zstd (de)compression library}
  spec.description   = %q{Zlib drop-in replacement implementing Zstd (de)compression algorithm}
  spec.homepage      = 'https://bitbucket.org/fougas/zstdlib'
  spec.license       = 'BSD-3-Clause'
  spec.files         = (
      ['Rakefile', 'Gemfile'] +
      %w(*.md lib/*.rb test/*.rb).collect {|glob| Dir[glob]} +
      %w(ruby/**/*.c zstd*/**/*.[ch] zlib*/**/*.[ch] zlib*/**/extconf.rb *.mk).collect {|glob| Dir['ext/zstdlib/' << glob]}
  ).flatten
  spec.extensions    = 'ext/zstdlib/extconf.rb'
  spec.platform      = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.2.0'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rake-compiler'
  spec.add_development_dependency 'rake-compiler-dock', '~> 0.7.0'
end
