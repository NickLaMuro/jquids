module Jquids
  module FormHelpers

    def jquids_tag(name, value=nil, options = {})
      Jquids.jquids_process_options(options)

      jsonify_opts options

      value = Jquids.format_time(value)

      options[:class] ? options[:class] += " #{jquids_class(options)}" : options[:class] = jquids_class(options)

      text_field_tag(name, value, options)
    end

    def jquids(model, method, options ={})
      obj = options[:object] || instance_variable_get("@#{model}")
      Jquids.jquids_process_options(options)

      jsonify_opts options

      options[:value] ||=
        begin
          obj.send(method).strftime(Jquids.date_format_string(false))
        rescue
          nil
        end

      options[:class] ? options[:class] += " #{jquids_class(options)}" : options[:class] = jquids_class(options)

      text_field(model, method, options)
    end

    def jsonify_opts(options)
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

    def jquids_class(options)
      result = "jquids_"
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
      def jquids(method, options = {})
        @template.jquids(@object_name, method, options.merge(:object => @object))
      end
    end
  end
end
