require "rubygems"
#require "rspec/core/rake_task"
require "rspec/core/rake_task" if Gem.source_index.find_name('rspec').map {|x| x.version}.first.version.to_i >= 2
require "spec/rake/spectask" if Gem.source_index.find_name('rspec').map {|x| x.version}.first.version.to_i < 2
require "lib/jq_ui_date_select/constants/version"

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

desc "Build the gem"
task :build do
  puts "Building the gem"
  `gem build jq_ui_date_select.gemspec`
end

desc "build and install as a gem"
task :install => :build do
  puts "Installing..."
  `gem install jq_ui_date_select-#{JqUiDateSelect::VERSION}.gem`
end

