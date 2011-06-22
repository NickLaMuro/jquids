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
    t.spec_files = "./spec/**/*_spec.rb" # not needed, it' a default.
    # Put spec opts in a file named spec.opts in your spec folder
  end
end
