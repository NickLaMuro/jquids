$:.push File.expand_path("../lib", __FILE__)
require "jquids/constants/version"

Gem::Specification.new do |s|
  s.name = "jquids"
  s.version = Jquids::VERSION
  s.platform = Gem::Platform::RUBY
  s.summary = "Integrating the jQueryUI date picker for Rails"
  s.description = "Integrating the jQueryUI date picker for Rails"
  s.authors = "Nick LaMuro"
  s.email = "nicklamuro@gmail.com"
  s.homepage = "https://github.com/NickLaMuro/jquids"

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {spec}/*`.split("\n")
  s.require_paths = ["lib"]
end
