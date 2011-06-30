module JqUiDateSelect
  module FormHelpers

    def jq_ui_date_select_tag(name, value=nil, options = {})
      options[:class] ? options[:class] += " jq_ui_ds_dp" : options[:class] = "jq_ui_ds_dp"
      JqUiDateSelect.jq_ui_date_select_process_options(options)

      unless options[:datepicker_options].nil?
        options["data-jqdatepicker"] = 
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

      value = JqUiDateSelect.format_time(value)
      text_field_tag(name, value, options)
    end

    def jq_ui_date_select(model, method, options ={})
      obj = options[:object] || instance_variable_get("@#{model}")
      options[:class] ? options[:class] += " jq_ui_ds_dp" : options[:class] = "jq_ui_ds_dp"
      JqUiDateSelect.jq_ui_date_select_process_options(options)

      unless options[:datepicker_options].nil?
        options["data-jqdatepicker"] =
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

      options[:value] ||=
        begin
          obj.send(method).strftime(JqUiDateSelect.date_format_string(false))
        rescue
          nil
        end

      text_field(model, method, options)
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
