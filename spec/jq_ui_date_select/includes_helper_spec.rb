require File.dirname(__FILE__) + '/../spec_helper'
require 'open-uri'

describe "InludesHelper" do

  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::AssetTagHelper
  include JqUiDateSelect::IncludesHelper

  describe "The jq_ui_default_stylesheet function" do

    describe "with no args" do

      it "should return 'http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/themes/base/jquery-ui.css'" do
        jq_ui_stylesheet.should == "http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/themes/base/jquery-ui.css"
      end

    end

    describe "with a args (:unknown_style) that doesn't exist" do

      it "should raise a JqUiDateSelect::NoStyleFoundError" do
        expect{ jq_ui_stylesheet :unknown_style }.to raise_error(JqUiDateSelect::NotAKnownStyle, "JqUiDateSelect: Unrecognized style specification: unknown_style")
      end

    end

    STYLES.each do |style|

      describe "with args of #{style[0]}" do

        it "should return 'http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/themes/#{style[1]}/jquery-ui.css'" do
          jq_ui_stylesheet(style[0]).should == "http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/themes/#{style[1]}/jquery-ui.css"
        end

        it "should curl and return the jQuery css header comment" do
          f = open("http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/themes/#{style[1]}/jquery-ui.css")
          f.first.should == "/*\n"
          f.first.should == " * jQuery UI CSS Framework 1.8.13\n"
          f.first.should == " *\n"
          f.first.should == " * Copyright 2011, AUTHORS.txt (http://jqueryui.com/about)\n"
          f.first.should == " * Dual licensed under the MIT or GPL Version 2 licenses.\n"
          f.first.should == " * http://jquery.org/license\n"
          f.first.should == " *\n"
          f.first.should == " * http://docs.jquery.com/UI/Theming/API\n"
          f.first.should == " */\n"
        end

      end

    end

  end

  describe "The jq_ui_javascripts function" do

    it "should return an array" do
      jq_ui_javascripts.is_a?(Array).should == true
    end

    it "should include 'https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js'" do
      jq_ui_javascripts.should include("https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js")
    end

    it "should include 'http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/jquery-ui.min.js'" do
      jq_ui_javascripts.should include("http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/jquery-ui.min.js")
    end

  end

  describe "The jq_ui_javascripts function" do

    describe "with no args" do

      it "has a style sheetlink tag" do
        jq_ui_date_select_includes.should include("<link href=\"http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/themes/base/jquery-ui.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />")
      end

    end

  end

end
