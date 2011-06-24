require "rubygems"
#require "rspec"
require "rspec" if Gem.source_index.find_name('rspec').map {|x| x.version}.first.version.to_i >= 2
require "spec" if Gem.source_index.find_name('rspec').map {|x| x.version}.first.version.to_i < 2
begin
  require "json"
rescue LoadError
  puts "'json' gem doesn't exist.  Assuming Rails 3 is installed.'"
end

require "action_controller"
require "action_pack"
require "action_view"
require "active_support"
require "active_support/core_ext"

$: << (File.dirname(__FILE__) + "/../lib")
require "jq_ui_date_select"

#RSpec.configure do |config|
#end
