require "jquids/jquids.rb"
require "jquids/includes_helper.rb"
require "jquids/form_helpers.rb"
require "jquids/errors/not_a_known_format.rb"
require "jquids/errors/not_a_known_style.rb"

ActionView::Helpers::FormHelper.send(:include, Jquids::FormHelpers)
ActionView::Base.send(:include, Jquids::FormHelpers)
ActionView::Base.send(:include, Jquids::IncludesHelper)
