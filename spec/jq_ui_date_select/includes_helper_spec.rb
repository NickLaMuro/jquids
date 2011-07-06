require File.dirname(__FILE__) + '/../spec_helper'
require 'open-uri'

describe JqUiDateSelect::IncludesHelper do

  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::AssetTagHelper
  include JqUiDateSelect::IncludesHelper

  before(:each) do
    JqUiDateSelect.instance_variable_set :@jq_ui_date_select_format, nil
  end

  describe "The jq_ui_default_stylesheet function" do

    describe "with no args" do

      it "should return 'https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/themes/base/jquery-ui.css'" do
        jq_ui_stylesheet.should == "https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/themes/base/jquery-ui.css"
      end

    end

    describe "with a args (:unknown_style) that doesn't exist" do

      it "should raise a JqUiDateSelect::NoStyleFoundError" do
        expect{ jq_ui_stylesheet :unknown_style }.to raise_error(JqUiDateSelect::NotAKnownStyle, "JqUiDateSelect: Unrecognized style specification: unknown_style")
      end

    end

    JqUiDateSelect::STYLES.each do |style|

      describe "with args of #{style[0]}" do

        it "should return 'https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/themes/#{style[1]}/jquery-ui.css'" do
          jq_ui_stylesheet(style[0]).should == "https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/themes/#{style[1]}/jquery-ui.css"
        end

        #it "should curl and return the jQuery css header comment" do
          #f = open("http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/themes/#{style[1]}/jquery-ui.css")
          #f.first.should == "/*\n"
          #f.first.should == " * jQuery UI CSS Framework 1.8.13\n"
          #f.first.should == " *\n"
          #f.first.should == " * Copyright 2011, AUTHORS.txt (http://jqueryui.com/about)\n"
          #f.first.should == " * Dual licensed under the MIT or GPL Version 2 licenses.\n"
          #f.first.should == " * http://jquery.org/license\n"
          #f.first.should == " *\n"
          #f.first.should == " * http://docs.jquery.com/UI/Theming/API\n"
          #f.first.should == " */\n"
        #end

      end

    end

  end

  describe "The jq_ui_javascripts function" do

    describe "where jq" do

      describe "equals latest version" do

        it "does include 'https://ajax.googleapis.com/ajax/libs/jquery/'" do
          jq_ui_javascripts(JqUiDateSelect::JQVersions.last, JqUiDateSelect::UIVersions.last, JqUiDateSelect::TimepickerTags.last).select {|x| x =~ /https:\/\/ajax.googleapis.com\/ajax\/libs\/jquery\//}.should_not == []
        end

      end

      describe "equals :none" do

        it "doesn't include 'https://ajax.googleapis.com/ajax/libs/jquery/'" do
          jq_ui_javascripts(:none, JqUiDateSelect::UIVersions.last, JqUiDateSelect::TimepickerTags.last).select {|x| x =~ /https:\/\/ajax.googleapis.com\/ajax\/libs\/jquery\//}.should == []
        end

      end

      describe "equals nil" do

        it "doesn't include 'https://ajax.googleapis.com/ajax/libs/jquery/'" do
          jq_ui_javascripts(nil, JqUiDateSelect::UIVersions.last, JqUiDateSelect::TimepickerTags.last).select {|x| x =~ /https:\/\/ajax.googleapis.com\/ajax\/libs\/jquery\//}.should == []
        end

      end

      describe "equals false" do

        it "doesn't include 'https://ajax.googleapis.com/ajax/libs/jquery/'" do
          jq_ui_javascripts(false, JqUiDateSelect::UIVersions.last, JqUiDateSelect::TimepickerTags.last).select {|x| x =~ /https:\/\/ajax.googleapis.com\/ajax\/libs\/jquery\//}.should == []
        end

      end

      JqUiDateSelect::JQVersions.each do |v|

        describe "equals '#{v}'" do

          it "includes 'https://ajax.googleapis.com/ajax/libs/jquery/#{v}/jquery.min.js'" do
            jq_ui_javascripts(v, JqUiDateSelect::UIVersions.last, JqUiDateSelect::TimepickerTags.last).should include("https://ajax.googleapis.com/ajax/libs/jquery/#{v}/jquery.min.js")
          end

        end

      end

      describe "equals '9001'" do

        it "includes 'https://ajax.googleapis.com/ajax/libs/jquery/#{JqUiDateSelect::JQVersions.last}/jquery.min.js'" do
          jq_ui_javascripts('9001', JqUiDateSelect::UIVersions.last, JqUiDateSelect::TimepickerTags.last).should include("https://ajax.googleapis.com/ajax/libs/jquery/#{JqUiDateSelect::JQVersions.last}/jquery.min.js")
        end

      end

    end

    describe "where ui" do

      describe "equals :none" do

        it "does include 'https://ajax.googleapis.com/ajax/libs/jqueryui/'" do
          jq_ui_javascripts(JqUiDateSelect::JQVersions.last, JqUiDateSelect::UIVersions.last, JqUiDateSelect::TimepickerTags.last).select {|x| x =~ /https:\/\/ajax.googleapis.com\/ajax\/libs\/jqueryui\//}.should_not == []
        end

      end

      describe "equals :none" do

        it "doesn't include 'https://ajax.googleapis.com/ajax/libs/jqueryui/'" do
          jq_ui_javascripts(JqUiDateSelect::JQVersions.last, :none, JqUiDateSelect::TimepickerTags.last).select {|x| x =~ /https:\/\/ajax.googleapis.com\/ajax\/libs\/jqueryui\//}.should == []
        end

      end

      describe "equals nil" do

        it "doesn't include 'https://ajax.googleapis.com/ajax/libs/jqueryui/'" do
          jq_ui_javascripts(JqUiDateSelect::JQVersions.last, nil, JqUiDateSelect::TimepickerTags.last).select {|x| x =~ /https:\/\/ajax.googleapis.com\/ajax\/libs\/jqueryui\//}.should == []
        end

      end

      describe "equals false" do

        it "doesn't include 'https://ajax.googleapis.com/ajax/libs/jqueryui/'" do
          jq_ui_javascripts(JqUiDateSelect::JQVersions.last, false, JqUiDateSelect::TimepickerTags.last).select {|x| x =~ /https:\/\/ajax.googleapis.com\/ajax\/libs\/jqueryui\//}.should == []
        end

      end

      JqUiDateSelect::UIVersions.each do |v|
        describe "equals '#{v}'" do

          it "includes 'https://ajax.googleapis.com/ajax/libs/jqueryui/#{v}/jquery-ui.min.js'" do
            jq_ui_javascripts(JqUiDateSelect::UIVersions.last, v, JqUiDateSelect::TimepickerTags.last).should include("https://ajax.googleapis.com/ajax/libs/jqueryui/#{v}/jquery-ui.min.js")
          end

        end

      end

      describe "equals '9001'" do

        it "includes 'https://ajax.googleapis.com/ajax/libs/jqueryui/#{JqUiDateSelect::UIVersions.last}/jquery-ui.min.js'" do
          jq_ui_javascripts(JqUiDateSelect::UIVersions.last, 9001, JqUiDateSelect::TimepickerTags.last).should include("https://ajax.googleapis.com/ajax/libs/jqueryui/#{JqUiDateSelect::UIVersions.last}/jquery-ui.min.js")
        end

      end

    end

    describe "where timepicker" do

      describe "equals the latest version" do

        it "does includes 'https://raw.github.com/trentrichardson/jQuery-Timepicker-Addon/'" do
          jq_ui_javascripts(JqUiDateSelect::UIVersions.last, JqUiDateSelect::UIVersions.last, JqUiDateSelect::TimepickerTags.last).select {|x| x =~ /https:\/\/raw.github.com\/trentrichardson\/jQuery-Timepicker-Addon\//}.should_not == [] 
        end

      end

      describe "equals :none" do

        it "doesn't includes 'https://raw.github.com/trentrichardson/jQuery-Timepicker-Addon/'" do
          jq_ui_javascripts(JqUiDateSelect::UIVersions.last, JqUiDateSelect::UIVersions.last, :none).select {|x| x =~ /https:\/\/raw.github.com\/trentrichardson\/jQuery-Timepicker-Addon\//}.should == [] 
        end

      end

      describe "equals false" do

        it "doesn't includes 'https://raw.github.com/trentrichardson/jQuery-Timepicker-Addon/'" do
          jq_ui_javascripts(JqUiDateSelect::UIVersions.last, JqUiDateSelect::UIVersions.last, false).select {|x| x =~ /https:\/\/raw.github.com\/trentrichardson\/jQuery-Timepicker-Addon\//}.should == [] 
        end

      end

      describe "equals nil" do

        it "doesn't includes 'https://raw.github.com/trentrichardson/jQuery-Timepicker-Addon/'" do
          jq_ui_javascripts(JqUiDateSelect::UIVersions.last, JqUiDateSelect::UIVersions.last, nil).select {|x| x =~ /https:\/\/raw.github.com\/trentrichardson\/jQuery-Timepicker-Addon\//}.should == [] 
        end

      end

      JqUiDateSelect::TimepickerTags.each do |v|
        describe "equals '#{v}'" do

          it "includes 'https://raw.github.com/trentrichardson/jQuery-Timepicker-Addon/#{v}/jquery-ui-timepicker-addon.js'" do
            jq_ui_javascripts(JqUiDateSelect::UIVersions.last, JqUiDateSelect::UIVersions.last, v).should include("https://raw.github.com/trentrichardson/jQuery-Timepicker-Addon/#{v}/jquery-ui-timepicker-addon.js")
          end

        end

      end

      describe "equals '9001'" do

        it "includes 'https://raw.github.com/trentrichardson/jQuery-Timepicker-Addon/#{JqUiDateSelect::TimepickerTags.last}/jquery-ui-timepicker-addon.js'" do
          jq_ui_javascripts(JqUiDateSelect::UIVersions.last, JqUiDateSelect::UIVersions.last, 9001).should include("https://raw.github.com/trentrichardson/jQuery-Timepicker-Addon/#{JqUiDateSelect::TimepickerTags.last}/jquery-ui-timepicker-addon.js")
        end

      end
      
    end

  end

  describe "The jq_ui_date_select_includes function" do

    it "has a javascript tag for jQuery" do
      jq_ui_date_select_includes.should include("<script src=\"https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js\" type=\"text/javascript\"></script>")
    end

    it "has a javascript tag for jQuery UI" do
      jq_ui_date_select_includes.should include("<script src=\"https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/jquery-ui.min.js\" type=\"text/javascript\"></script>")
    end

    it "has the options parsing script" do
      jq_ui_date_select_includes.should include('$(document).ready(function(){$(".jq_ui_ds_dp").each(function(){var s=$(this).attr("data-jquipicker");$(this).attr("data-jquipicker")?$(this).datepicker(JSON.parse(s)):$(this).datepicker()});$(".jq_ui_ds_tp").each(function(){var s=$(this).attr("data-jquipicker");$(this).attr("data-jquipicker")?$(this).timepicker(JSON.parse(s)):$(this).timepicker()});$(".jq_ui_ds_dtp").each(function(){var s=$(this).attr("data-jquipicker");$(this).attr("data-jquipicker")?$(this).datetimepicker(JSON.parse(s)):$(this).datetimepicker()})});</script>')
    end

    it "has the datepicker.setDefaults javascript function" do
      jq_ui_date_select_includes.should include("<script type=\"text/javascript\">$.datepicker.setDefaults({")
    end

    it "does not have the timepicker.setDefaults javascript function" do
      jq_ui_date_select_includes.should_not include("$.timepicker.setDefaults({")
    end

    it "does not have the timepicker css" do
      jq_ui_date_select_includes().should_not include('<style type="text/css">.ui-timepicker-div .ui-widget-header{margin-bottom:8px;}.ui-timepicker-div dl{text-align:left;}.ui-timepicker-div dl dt{height:25px;}.ui-timepicker-div dl dd{margin:-25px 0 10px 65px;}.ui-timepicker-div td{font-size:90%;}</style>')
    end

    describe "without datepicker_options" do

      it "has changeMonth set to true" do
        jq_ui_date_select_includes.should include('"changeMonth":true')
      end

      it "has changeYear set to true" do
        jq_ui_date_select_includes.should include('"changeYear":true')
      end

      it "has showOtherMonths set to true" do
        jq_ui_date_select_includes.should include('"showOtherMonths":true')
      end

      it "has selectOtherMonths set to true" do
        jq_ui_date_select_includes.should include('"selectOtherMonths":true')
      end

      it "has dateFormat set to ':natural'" do
        jq_ui_date_select_includes.should include('"dateFormat":"MM dd, yy"')
      end

    end

    describe "without timepicker_options" do

      it "does not have timeFormat set to ':natural'" do
        jq_ui_date_select_includes.should_not include('"timeFormat":"hh:mm TT"')
      end

      it "does not have ampm set to true" do
        jq_ui_date_select_includes.should_not include('"ampm":true')
      end

    end

    describe "without timepicker_options but :TRTimepicker => v0.9.5" do

      it "returns timeFormat set to ':natural'" do
        jq_ui_date_select_includes(:TRTimepicker => "v0.9.5").should include('"timeFormat":"hh:mm TT"')
      end

      it "returns ampm set to true" do
        jq_ui_date_select_includes(:TRTimepicker => "v0.9.5").should include('"ampm":true')
      end

      it "returns the timepicker css" do
        jq_ui_date_select_includes(:TRTimepicker => "v0.9.5").should include('<style type="text/css">.ui-timepicker-div .ui-widget-header{margin-bottom:8px;}.ui-timepicker-div dl{text-align:left;}.ui-timepicker-div dl dt{height:25px;}.ui-timepicker-div dl dd{margin:-25px 0 10px 65px;}.ui-timepicker-div td{font-size:90%;}</style>')
      end

    end

    describe "without datepicker_options or timepicker_options and the format is set to finnish" do

      before(:each) do
        JqUiDateSelect.format = :finnish
      end

      it "has changeMonth set to true" do
        jq_ui_date_select_includes.should include('"changeMonth":true')
      end

      it "has changeYear set to true" do
        jq_ui_date_select_includes.should include('"changeYear":true')
      end

      it "has showOtherMonths set to true" do
        jq_ui_date_select_includes.should include('"showOtherMonths":true')
      end

      it "has selectOtherMonths set to true" do
        jq_ui_date_select_includes.should include('"selectOtherMonths":true')
      end

      it "has dateFormat set to ':finnish'" do
        jq_ui_date_select_includes.should include('"dateFormat":"dd.mm.yy"')
      end

      describe "with :TRTimepicker => 'v0.9.7'" do

        it "has timeFormat set to ':finish'" do
          jq_ui_date_select_includes(:TRTimepicker => "v0.9.5").should include('"timeFormat":"hh:mm"')
        end

        it "has ampm set to true" do
          jq_ui_date_select_includes(:TRTimepicker => "v0.9.5").should include('"ampm":false')
        end

        it "returns the timepicker css" do
          jq_ui_date_select_includes(:TRTimepicker => "v0.9.5").should include('<style type="text/css">.ui-timepicker-div .ui-widget-header{margin-bottom:8px;}.ui-timepicker-div dl{text-align:left;}.ui-timepicker-div dl dt{height:25px;}.ui-timepicker-div dl dd{margin:-25px 0 10px 65px;}.ui-timepicker-div td{font-size:90%;}</style>')
        end

      end

    end

    describe "without datepicker_options and the format is set to finnish using the function itself" do

      before(:each) do
        @output = jq_ui_date_select_includes(:format => :finnish) 
      end

      it "has changeMonth set to true" do
        @output.should include('"changeMonth":true')
      end

      it "has changeYear set to true" do
        @output.should include('"changeYear":true')
      end

      it "has showOtherMonths set to true" do
        @output.should include('"showOtherMonths":true')
      end

      it "has selectOtherMonths set to true" do
        @output.should include('"selectOtherMonths":true')
      end

      it "has dateFormat set to ':finnish'" do
        @output.should include('"dateFormat":"dd.mm.yy"')
      end

      describe "with :TRTimepicker => 'v0.9.7'" do

        before(:each) do
          @output = jq_ui_date_select_includes(:format => :finnish, :TRTimepicker => "v0.9.5") 
        end

        it "has timeFormat set to ':finish'" do
          @output.should include('"timeFormat":"hh:mm"')
        end

        it "has ampm set to true" do
          @output.should include('"ampm":false')
        end

      end

    end

    describe "with datepicker_options" do
      
      describe "of {:datepicker_options => {:autoSize => true}}" do

        it "has changeMonth set to true" do
          jq_ui_date_select_includes(:datepicker_options => {:autoSize => true}).should include('"changeMonth":true')
        end

        it "has changeYear set to true" do
          jq_ui_date_select_includes(:datepicker_options => {:autoSize => true}).should include('"changeYear":true')
        end

        it "has showOtherMonths set to true" do
          jq_ui_date_select_includes(:datepicker_options => {:autoSize => true}).should include('"showOtherMonths":true')
        end

        it "has selectOtherMonths set to true" do
          jq_ui_date_select_includes(:datepicker_options => {:autoSize => true}).should include('"selectOtherMonths":true')
        end

        it "has autoSize set to true" do
          jq_ui_date_select_includes(:datepicker_options => {:autoSize => true}).should include('"autoSize":true')
        end

        it "has dateFormat set to ':natural'" do
          jq_ui_date_select_includes(:datepicker_options => {:autoSize => true}).should include('"dateFormat":"MM dd, yy"')
        end

      end

      describe "overwriting the defaults" do

        before(:each) do
          @options = {:datepicker_options => {:changeMonth => false,
                                              :changeYear => false, 
                                              :showOtherMonths => false, 
                                              :selectOtherMonths => false}}
        end

        it "has changeMonth set to false" do
          jq_ui_date_select_includes(@options).should include('"changeMonth":false')
        end

        it "has changeYear set to false" do
          jq_ui_date_select_includes(@options).should include('"changeYear":false')
        end

        it "has showOtherMonths set to false" do
          jq_ui_date_select_includes(@options).should include('"showOtherMonths":false')
        end

        it "has selectOtherMonths set to false" do
          jq_ui_date_select_includes(@options).should include('"selectOtherMonths":false')
        end

        it "has dateFormat set to ':natural'" do
          jq_ui_date_select_includes(@options).should include('"dateFormat":"MM dd, yy"')
        end

      end

    end

    describe "with CalendarDateSelect style options" do
      
      describe "of :year_range => 2000..2020" do

        it "has changeMonth set to true" do
          jq_ui_date_select_includes(:year_range => 2000..2020).should include('"changeMonth":true')
        end

        it "has changeYear set to true" do
          jq_ui_date_select_includes(:year_range => 2000..2020).should include('"changeYear":true')
        end

        it "has showOtherMonths set to true" do
          jq_ui_date_select_includes(:year_range => 2000..2020).should include('"showOtherMonths":true')
        end

        it "has selectOtherMonths set to true" do
          jq_ui_date_select_includes(:year_range => 2000..2020).should include('"selectOtherMonths":true')
        end

        it "has autoSize set to true" do
          jq_ui_date_select_includes(:year_range => 2000..2020).should include('"yearRange":"2000:2020"')
        end

        it "has dateFormat set to ':natural'" do
          jq_ui_date_select_includes(:year_range => 2000..2020).should include('"dateFormat":"MM dd, yy"')
        end

      end

    end

    describe "with no args" do

      it "has the :base stylesheet link tag" do
        jq_ui_date_select_includes.should include("<link href=\"https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/themes/base/jquery-ui.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />")
      end

    end

    JqUiDateSelect::JQVersions.each do |v|
      describe "with args of {:jQuery => '#{v}'}" do

        it "has no jQuery javascript link tag" do
          jq_ui_date_select_includes(:jQuery => v).should include("<script src=\"https://ajax.googleapis.com/ajax/libs/jquery/#{v}/jquery.min.js\" type=\"text/javascript\"></script>")
        end

      end
    end


    describe "with args of {:jQuery => :none}" do

      it "has no jQuery javascript link tag" do
        jq_ui_date_select_includes(:jQuery => :none).should_not include("<script src=\"https://ajax.googleapis.com/ajax/libs/jquery/")
      end

    end

    describe "with args of {:jQuery => nil}" do

      it "has no jQuery javascript link tag" do
        jq_ui_date_select_includes(:jQuery => nil).should_not include("<script src=\"https://ajax.googleapis.com/ajax/libs/jquery/")
      end

    end

    describe "with args of {:jQuery => false}" do

      it "has no jQuery javascript link tag" do
        jq_ui_date_select_includes(:jQuery => false).should_not include("<script src=\"https://ajax.googleapis.com/ajax/libs/jquery/")
      end

    end

    JqUiDateSelect::UIVersions.each do |v|
      describe "with args of {:jQueryUI => '#{v}'}" do

        it "has jQuery UI javascript link tag with a version of '#{v}'" do
          jq_ui_date_select_includes(:jQueryUI => v).should include("<script src=\"https://ajax.googleapis.com/ajax/libs/jqueryui/#{v}/jquery-ui.min.js\" type=\"text/javascript\"></script>")
        end

      end
    end

    describe "with args of {:jQueryUI => :none}" do

      it "has no jQuery UI javascript link tag" do
        jq_ui_date_select_includes(:jQueryUI => :none).should_not include("<script src=\"https://ajax.googleapis.com/ajax/libs/jqueryui/")
      end

    end

    describe "with args of {:jQueryUI => nil}" do

      it "has no jQuery UI javascript link tag" do
        jq_ui_date_select_includes(:jQueryUI => nil).should_not include("<script src=\"https://ajax.googleapis.com/ajax/libs/jqueryui/")
      end

    end

    describe "with args of {:jQueryUI => false}" do

      it "has no jQuery UI javascript link tag" do
        jq_ui_date_select_includes(:jQueryUI => false).should_not include("<script src=\"https://ajax.googleapis.com/ajax/libs/jqueryui/")
      end

    end

    JqUiDateSelect::STYLES.each do |style|

      describe "with args of {:style => #{style[0]}}" do

        it "has the #{style[0]} stylesheet link tag" do
          jq_ui_date_select_includes(:style => style[0]).should include("<link href=\"https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/themes/#{style[1]}/jquery-ui.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />")
        end

      end

    end

    describe "with args of {:style => :none}" do

      it "has no stylesheet" do
        jq_ui_date_select_includes(:style => :none).should_not include("<link href=\"https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/themes/")
      end

    end

    describe "with args of {:style => nil}" do

      it "has no stylesheet" do
        jq_ui_date_select_includes(:style => nil).should_not include("<link href=\"https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/themes/")
      end

    end

    describe "with args of {:style => false}" do

      it "has no stylesheet" do
        jq_ui_date_select_includes(:style => false).should_not include("<link href=\"https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/themes/")
      end

    end

    JqUiDateSelect::TimepickerTags.each do |v|

      describe "with args of {:TRTimepicker => #{v}}" do

        it "has the #{v} Trent Richardson Timepicker javascript link tag" do
          jq_ui_date_select_includes(:TRTimepicker => v).should include("<script src=\"https://raw.github.com/trentrichardson/jQuery-Timepicker-Addon/#{v}/jquery-ui-timepicker-addon.js\" type=\"text/javascript\"></script>")
        end

      end

    end

    describe "with no :TRTimepicker key" do

      it "doesn't return a Trent Richardson Timepicker javascript link tag" do
        jq_ui_date_select_includes().should_not include("<script src=\"https://raw.github.com/trentrichardson/jQuery-Timepicker-Addon/")
      end

    end

    describe "with args of {:TRTimepicker => :none}" do

      it "doesn't return a Trent Richardson Timepicker javascript link tag" do
        jq_ui_date_select_includes(:TRTimepicker => :none).should_not include("<script src=\"https://raw.github.com/trentrichardson/jQuery-Timepicker-Addon/")
      end
      
    end

    describe "with args of {:TRTimepicker => false}" do

      it "doesn't return a Trent Richardson Timepicker javascript link tag" do
        jq_ui_date_select_includes(:TRTimepicker => false).should_not include("<script src=\"https://raw.github.com/trentrichardson/jQuery-Timepicker-Addon/")
      end
      
    end

    describe "with args of {:TRTimepicker => nil}" do

      it "doesn't return a Trent Richardson Timepicker javascript link tag" do
        jq_ui_date_select_includes(:TRTimepicker => nil).should_not include("<script src=\"https://raw.github.com/trentrichardson/jQuery-Timepicker-Addon/")
      end
      
    end

  end

end
