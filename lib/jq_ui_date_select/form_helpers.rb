module JqUiDateSelect
  module FormHelpers

    def jq_ui_date_select_tag(name, value=nil, options = {})
      options[:class] ? options[:class] += " jq_ui_dp" : options[:class] = "jq_ui_dp"

      options["data-jqdatepicker"] = JSON.unparse(options.delete(:datepicker_options)) if options[:datepicker_options]

      value = JqUiDateSelect.format_time(value)
      text_field_tag(name, value, options)
    end

  end
end
