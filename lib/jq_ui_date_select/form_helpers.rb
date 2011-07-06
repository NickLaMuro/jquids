module JqUiDateSelect
  module FormHelpers

    def jq_ui_date_select_tag(name, value=nil, options = {})
      JqUiDateSelect.jq_ui_date_select_process_options(options)

      jsonify_options options

      value = JqUiDateSelect.format_time(value)

      options[:class] ? options[:class] += " #{jq_ui_ds_class(options)}" : options[:class] = jq_ui_ds_class(options)

      text_field_tag(name, value, options)
    end

    def jq_ui_date_select(model, method, options ={})
      obj = options[:object] || instance_variable_get("@#{model}")
      JqUiDateSelect.jq_ui_date_select_process_options(options)

      jsonify_options options

      options[:value] ||=
        begin
          obj.send(method).strftime(JqUiDateSelect.date_format_string(false))
        rescue
          nil
        end

      options[:class] ? options[:class] += " #{jq_ui_ds_class(options)}" : options[:class] = jq_ui_ds_class(options)

      text_field(model, method, options)
    end

    def jsonify_options(options)
      unless options[:datepicker_options].nil? and options[:timepicker_options].nil?
        options[:datepicker_options] ||= {}
        options[:datepicker_options] = options[:datepicker_options].merge(options.delete(:timepicker_options)) unless options[:timepicker_options].nil?
        options["data-jquipicker"] =
          if options[:datepicker_options].respond_to?(:to_json)
            options.delete(:datepicker_options).to_json
          else
            begin
              JSON.unparse(options.delete(:datepicker_options))
            rescue
              ""
            end
          end
      end
    end

    def jq_ui_ds_class(options)
      result = "jq_ui_ds_"
      result << "d" unless options.delete(:calendar) == false
      result << "t" if options.delete(:time) == true
      result << "p"
    end

  end
end

# Helper method for form builders
module ActionView
  module Helpers
    class FormBuilder
      def jq_ui_date_select(method, options = {})
        @template.jq_ui_date_select(@object_name, method, options.merge(:object => @object))
      end
    end
  end
end
