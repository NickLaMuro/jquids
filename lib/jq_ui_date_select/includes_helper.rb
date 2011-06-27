module JqUiDateSelect
  module IncludesHelper

    require File.dirname(__FILE__) + "/constants/styles.rb"

    def jq_ui_stylesheet(style = :base)
      raise JqUiDateSelect::NotAKnownStyle, "JqUiDateSelect: Unrecognized style specification: #{style}" unless JqUiDateSelect::STYLES.has_key?(style)
      "http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/themes/#{JqUiDateSelect::STYLES[style]}/jquery-ui.css"
    end

    def jq_ui_javascripts
      includes = []
      includes << "https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"
      includes << "http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/jquery-ui.min.js"
      includes
    end

    # Includes the stylesheets and javescripts into what ever view this is
    # called to.
    #
    # By adding a :datepicker_options hash the options hash, you can change the
    # defaults styles that are intially applied to all datepicker instances.
    # Those defaults can be overwritten by each instance of the datepicker.
    #
    # To not include the style sheet into the layout, just pass :style => :none
    # (false or nil will also work)
    def jq_ui_date_select_includes(options = {})

      # Set the format for the datepickers
      JqUiDateSelect.format = options[:format] if options.has_key?(:format)
      html = ""

      if options.has_key?(:style)
        html <<  stylesheet_link_tag(jq_ui_stylesheet(options[:style])) + "\n" unless options[:style] == nil or options[:style] == :none or options[:style] == false
      else
        html << stylesheet_link_tag(jq_ui_stylesheet) + "\n"
      end

      html << javascript_include_tag(jq_ui_javascripts) + "\n"

      options[:datepicker_options] ||= {}
      
      # Some opiniated defaults (basically an attempt to make the jQuery
      # datepicker similar to the calendar_date_select with out making
      # modifications or having local dependencies)
      options[:datepicker_options][:showOtherMonths] = true if options[:datepicker_options][:showOtherMonths].nil?
      options[:datepicker_options][:selectOtherMonths] = true if options[:datepicker_options][:selectOtherMonths].nil?
      options[:datepicker_options][:changeMonth] = true if options[:datepicker_options][:changeMonth].nil?
      options[:datepicker_options][:changeYear] = true if options[:datepicker_options][:changeYear].nil?
      options[:datepicker_options][:dateFormat] = JqUiDateSelect.format[:js_date]


      datepicker_options = options[:datepicker_options].respond_to?(:to_json) ? options[:datepicker_options].to_json : JSON.unparse(options[:datepicker_options])

      html << '<script type="text/javascript">$.datepicker.setDefaults(' + datepicker_options + ');'

      # A minified version of this javascript.
      #   <script type="text/javascript">
      #     $(document).ready(function(){
      #        $(".jq_ui_dp_ds").each(function(){
      #          var s = $(this).attr("data-jqdatepicker");
      #          $(this).attr("data-jqdatepicker") ? $(this).datepicker(JSON.parse(s)) : $(this).datepicker();
      #        });
      #     });
      #   </script>
      #
      # Used to parse out options for each datepicker instance
      html << '$(document).ready(function(){$(".jq_ui_dp_ds").each(function(){var s=$(this).attr("data-jqdatepicker");$(this).attr("data-jqdatepicker")?$(this).datepicker(JSON.parse(s)):$(this).datepicker()})});</script>'
    end

  end
end
