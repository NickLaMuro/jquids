require "rubygems"
#require "rspec"
require "rspec" if Gem.source_index.find_name('rspec').map {|x| x.version}.first.version.to_i >= 2
require "spec" if Gem.source_index.find_name('rspec').map {|x| x.version}.first.version.to_i < 2

require "action_controller"
require "action_pack"
require "active_support"

$: << (File.dirname(__FILE__) + "/../lib")
require "jq_ui_date_select"

#RSpec.configure do |config|
#end
