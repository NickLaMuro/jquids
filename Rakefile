require "rspec/core/rake_task"

desc 'Default: run spec.'
task :default => :spec

desc "Run specs"
RSpec::Core::RakeTask.new do |t|
  t.pattern = "./spec/**/*_spec.rb" # not needed, it' a default.
  # Put spec opts in a file named .rspec in root
end
