require "lib/jq_ui_date_select/jq_ui_date_select.rb"
require "lib/jq_ui_date_select/includes_helper.rb"
require "lib/jq_ui_date_select/form_helpers.rb"
require "lib/jq_ui_date_select/errors/not_a_known_format.rb"
require "lib/jq_ui_date_select/errors/not_a_known_style.rb"

if Object.const_defined?(:Rails) && File.directory?(Rails.root.to_s + "/public")
  ActionView::Base.send(:include, JqUiDateSelect::IncludesHelper)
  ActionView::Helpers::FormHelper.send(:include, JqUiDateSelect::FormHelpers)
  
end
