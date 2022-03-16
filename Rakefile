require 'rake/testtask'
require 'rake/extensiontask'
require 'rake_compiler_dock'


spec = Gem::Specification.load('zstdlib.gemspec')


platforms = %w[x86-mingw32 x64-mingw-ucrt x64-mingw32 x86_64-darwin arm64-darwin]


Rake::ExtensionTask.new('zstdlib_c', spec) do |t|
  t.cross_compile = true
  t.cross_platform = platforms
  t.cross_config_options << '--enable-cross-build'
end


namespace "gem" do
  platforms.each do |platform|
    desc "build native gem for #{platform}"
    # This runs on a host
    task platform do
      RakeCompilerDock.sh(<<~EOF, platform: platform)
        gem install bundler --no-document &&
        bundle &&
        bundle exec rake gem:#{platform}:buildit
      EOF
    end

    namespace platform do
      # This runs in the rake-compiler-dock docker container
      task "buildit" do
        # Use Task#invoke because the pkg/*gem task is defined at runtime
        Rake::Task["native:#{platform}"].invoke
        Rake::Task["pkg/#{spec.full_name}-#{Gem::Platform.new(platform)}.gem"].invoke
      end
    end
  end

  #
  desc "build native gem for all platforms"
  multitask 'all' => platforms

end


Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/*_test.rb']
end


# Build system explained: https://github.com/flavorjones/ruby-c-extensions-explained/tree/main/precompiled