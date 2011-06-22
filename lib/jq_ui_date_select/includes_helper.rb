module JqUiDateSelect
  module IncludesHelper

    require File.dirname(__FILE__) + "/constants/styles.rb"

    def jq_ui_stylesheet(style = :base)
      raise JqUiDateSelect::NotAKnownStyle, "JqUiDateSelect: Unrecognized style specification: #{style}" unless STYLES.has_key?(style)
      "http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/themes/#{STYLES[style]}/jquery-ui.css"
    end

    def jq_ui_javascripts
      includes = []
      includes << "https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"
      includes << "http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/jquery-ui.min.js"
      includes
    end

    def jq_ui_date_select_includes(options = {})
      html = ""

      if options.has_key?(:style)
          html <<  stylesheet_link_tag(jq_ui_stylesheet(options[:style])) + "\n" unless options[:style] == nil or options[:style] == :none or options[:style] == false
      else
        html << stylesheet_link_tag(jq_ui_stylesheet) + "\n"
      end

      html << javascript_include_tag(jq_ui_javascripts)
    end

  end
end
