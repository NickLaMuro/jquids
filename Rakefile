require "rubygems"
#require "rspec/core/rake_task"
require "rspec/core/rake_task" if Gem.source_index.find_name('rspec').map {|x| x.version}.first.version.to_i >= 2
require "spec/rake/spectask" if Gem.source_index.find_name('rspec').map {|x| x.version}.first.version.to_i < 2

desc 'Default: run spec.'
task :default => :spec

if Gem.source_index.find_name('rspec').map {|x| x.version}.first.version.to_i >= 2
  desc "Run specs"
  RSpec::Core::RakeTask.new do |t|
    t.pattern = "./spec/**/*_spec.rb" # not needed, it' a default.
    # Put spec opts in a file named .rspec in root
  end
elsif Gem.source_index.find_name('rspec').map {|x| x.version}.first.version.to_i < 2
  desc "Run specs"
  Spec::Rake::SpecTask.new do |t|
    t.spec_files = "./spec/**/*_spec.rb"
    # Put spec opts in a file named spec.opts in your spec folder
  end
end

gemspec = eval(File.read(Dir["*.gemspec"].first))

desc "Validate the gemspec"
task :gemspec do
  puts "Validating the gem..."
  gemspec.validate
end
 
desc "Build gem locally"
task :build => :gemspec do
  puts "Building the gem..."
  system "gem build #{gemspec.name}.gemspec"
  FileUtils.mkdir_p "pkg"
  FileUtils.mv "#{gemspec.name}-#{gemspec.version}.gem", "pkg"
end
 
desc "Install gem locally"
task :install => :build do
  puts "Installing..."
  system "gem install pkg/#{gemspec.name}-#{gemspec.version}"
end

