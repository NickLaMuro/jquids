module Jquids
  module IncludesHelper

    require File.dirname(__FILE__) + "/constants/styles.rb"
    require File.dirname(__FILE__) + "/constants/jq_versions.rb"
    require File.dirname(__FILE__) + "/constants/ui_versions.rb"
    require File.dirname(__FILE__) + "/constants/timepicker_tags.rb"

    def jq_ui_stylesheet(style = :base)
      raise Jquids::NotAKnownStyle, "Jquids: Unrecognized style specification: #{style}" unless Jquids::STYLES.has_key?(style)
      "https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/themes/#{Jquids::STYLES[style]}/jquery-ui.css"
    end

    def jq_ui_javascripts(jq, ui, tp)
      includes = []
      unless jq == :none or jq == nil or jq == false
        jq = Jquids::JQVersions.member?(jq) ? jq : Jquids::JQVersions.last
        includes << "https://ajax.googleapis.com/ajax/libs/jquery/#{jq}/jquery.min.js" 
      end
      unless ui == :none or ui == nil or ui == false
        ui = Jquids::UIVersions.member?(ui) ? ui : Jquids::UIVersions.last
        includes << "https://ajax.googleapis.com/ajax/libs/jqueryui/#{ui}/jquery-ui.min.js" 
      end
      unless tp == :none or tp == nil or tp == false
        tp = Jquids::TimepickerTags.member?(tp) ? tp : Jquids::TimepickerTags.last
        includes << "https://raw.github.com/trentrichardson/jQuery-Timepicker-Addon/#{tp}/jquery-ui-timepicker-addon.js"
      end
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
    def jquids_includes(options = {})

      # Set the format for the datepickers
      Jquids.format = options[:format] if options.has_key?(:format)
      html_out = ""

      if options.has_key?(:style)
        html_out <<  stylesheet_link_tag(jq_ui_stylesheet(options[:style])) + "\n" unless options[:style] == nil or options[:style] == :none or options[:style] == false
      else
        html_out << stylesheet_link_tag(jq_ui_stylesheet) + "\n"
      end

      jq_vrs = options.has_key?(:jQuery) ? options[:jQuery] : Jquids::JQVersions.last
      ui_vrs = options.has_key?(:jQueryUI) ? options[:jQueryUI] : Jquids::UIVersions.last
      trtp_vrs = options.has_key?(:TRTimepicker) ? options[:TRTimepicker] : :none

      # A little bit of css of the timepicker, and it is not added if the
      # timepicker javascript file is not included
      unless trtp_vrs == :none or trtp_vrs == false or trtp_vrs == nil
        html_out << "<style type=\"text/css\">.ui-timepicker-div .ui-widget-header{margin-bottom:8px;}.ui-timepicker-div dl{text-align:left;}.ui-timepicker-div dl dt{height:25px;}.ui-timepicker-div dl dd{margin:-25px 0 10px 65px;}.ui-timepicker-div td{font-size:90%;}</style>\n"
      end

      html_out << javascript_include_tag(jq_ui_javascripts(jq_vrs, ui_vrs, trtp_vrs)) + "\n"

      options[:datepicker_options] ||= {}
      
      # Some opiniated defaults (basically an attempt to make the jQuery
      # datepicker similar to the calendar_date_select with out making
      # modifications or having local dependencies)
      options[:datepicker_options][:showOtherMonths] = true if options[:datepicker_options][:showOtherMonths].nil?
      options[:datepicker_options][:selectOtherMonths] = true if options[:datepicker_options][:selectOtherMonths].nil?
      options[:datepicker_options][:changeMonth] = true if options[:datepicker_options][:changeMonth].nil?
      options[:datepicker_options][:changeYear] = true if options[:datepicker_options][:changeYear].nil?
      options[:datepicker_options][:dateFormat] = Jquids.format[:js_date]

      Jquids.jquids_process_options(options)

      # Decides whether the 'to_json' method exists (part of rails 3) or if the
      # gem needs to us the json gem
      datepicker_options = 
        if options[:datepicker_options].respond_to?(:to_json)
            options.delete(:datepicker_options).to_json
        else
          begin
            JSON.unparse(options.delete(:datepicker_options))
          rescue
            ""
          end
        end

      html_out << '<script type="text/javascript">$.datepicker.setDefaults(' + datepicker_options + ');'


      unless trtp_vrs == :none or trtp_vrs == false or trtp_vrs == nil
        options[:timepicker_options] ||= {}
        
        # Some opiniated defaults (basically an attempt to make the jQuery
        # datepicker similar to the calendar_date_select with out making
        # modifications or having local dependencies)
        # Sets the time format based off of the current format
        options[:timepicker_options][:ampm] = Jquids.format[:ampm]
        options[:timepicker_options][:timeFormat] = Jquids.format[:tr_js_time]

        timepicker_options = 
          if options[:timepicker_options].respond_to?(:to_json)
              options.delete(:timepicker_options).to_json
          else
            begin
              JSON.unparse(options.delete(:timepicker_options))
            rescue
              ""
            end
          end

        html_out << '$.timepicker.setDefaults(' + timepicker_options + ');'
      end

      # A minified version of this javascript.
      #   <script type="text/javascript">
      #     $(document).ready(function(){
      #       $(".jquids_dp").each(function(){
      #         var s = $(this).attr("data-jquipicker");
      #         $(this).attr("data-jquipicker") ? $(this).datepicker(JSON.parse(s)) : $(this).datepicker();
      #       });
      #       $(".jquids_tp").each(function(){
      #         var s = $(this).attr("data-jquipicker");
      #         $(this).attr("data-jquipicker") ? $(this).timepicker(JSON.parse(s)) : $(this).timepicker();
      #       });
      #       $(".jquids_dtp").each(function(){
      #         var s=$(this).attr("data-jquipicker");
      #         $(this).attr("data-jquipicker")?$(this).datetimepicker(JSON.parse(s)) : $(this).datetimepicker()
      #       })
      #     });
      #   </script>
      #
      # Used to parse out options for each datepicker instance
      html_out << '$(document).ready(function(){$(".jquids_dp").each(function(){var s=$(this).attr("data-jquipicker");$(this).attr("data-jquipicker")?$(this).datepicker(JSON.parse(s)):$(this).datepicker()});$(".jquids_tp").each(function(){var s=$(this).attr("data-jquipicker");$(this).attr("data-jquipicker")?$(this).timepicker(JSON.parse(s)):$(this).timepicker()});$(".jquids_dtp").each(function(){var s=$(this).attr("data-jquipicker");$(this).attr("data-jquipicker")?$(this).datetimepicker(JSON.parse(s)):$(this).datetimepicker()})});</script>'

      if html_out.respond_to?(:html_safe)
        return html_out.html_safe
      else
        return html_out
      end
    end

  end
end
