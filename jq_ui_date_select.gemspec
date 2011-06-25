$:.push File.expand_path("../lib", __FILE__)
require "jq_ui_date_select/constants/version"

Gem::Specification.new do |s|
  s.name = "jq_ui_date_select"
  s.version = JqUiDateSelect::VERSION
  s.platform = Gem::Platform::RUBY
  s.summary = "Integrating the jQueryUI date picker for Rails"
  s.description = "Integrating the jQueryUI date picker for Rails"
  s.authors = "Nick LaMuro"
  s.email = "nicklamuro@gmail.com"
  s.homepage = "https://github.com/NickLaMuro/jq_ui_date_select"

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {spec}/*`.split("\n")
  s.require_paths = ['lib']

end
