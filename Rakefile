require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rake/extensiontask'


spec = Gem::Specification.load('zstdlib.gemspec')


Rake::ExtensionTask.new('zstdlib', spec) do |t|
  t.cross_compile = true
  t.cross_platform = %w(x86-mingw32 x64-mingw32)
end


Gem::PackageTask.new(spec)


Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/*_test.rb']
end