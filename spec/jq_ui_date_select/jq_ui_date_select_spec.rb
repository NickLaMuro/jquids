require File.dirname(__FILE__) + '/../spec_helper'

describe JqUiDateSelect do
  include ActionView::Helpers::AssetTagHelper
  include JqUiDateSelect

  before(:each) do
    JqUiDateSelect.instance_variable_set :@jq_ui_date_select_format, nil
  end

  describe "The format function where:" do
    
    describe "The default format" do
   
      it "should return the natural format" do
        JqUiDateSelect.format.should == {:date => "%B %d, %Y", :time => " %I:%M %p", :js_date => "MM dd, yy", :tr_js_time => "hh:mm TT", :ampm => true}
      end

    end

    describe "Setting the format" do

      describe "with an invalid key" do

        it "should raise an JqUiDateSelect::NotAKnownFormat error" do
          expect{ JqUiDateSelect.format=(:not_a_valid_key) }.to raise_error(JqUiDateSelect::NotAKnownFormat, "JqUiDateSelect: Unrecognized format specification: not_a_valid_key")
        end

      end

      JqUiDateSelect::FORMATS.each do |format|

        describe "to '#{format[0]}'" do

          it "should start with a default of 'natural' format" do
            JqUiDateSelect.format.should == {:date => "%B %d, %Y", :time => " %I:%M %p", :js_date => "MM dd, yy", :tr_js_time => "hh:mm TT", :ampm => true}
          end

          it "should set the format to '#{format[0]}' when 'format=' is called" do
            JqUiDateSelect.format=(format[0])
            JqUiDateSelect.format.should == format[1]
          end

        end

      end

    end

  end

  describe "The date_format_string function where:" do

    describe "The format is the default state" do

      describe "when the time input is blank" do

        it "should return '%B %d, %Y'" do
          JqUiDateSelect.date_format_string.should == "%B %d, %Y"          
        end
        
      end

      describe "when the time input is false" do

        it "should return '%B %d, %Y'" do
          JqUiDateSelect.date_format_string(false).should == "%B %d, %Y"          
        end
        
      end

      describe "when the time input is true" do

        it "should return '%B %d, %Y %I:%M %p'" do
          JqUiDateSelect.date_format_string(true).should == "%B %d, %Y %I:%M %p"
        end
        
      end
      
    end

    describe "The format is set to ':american'" do

      before(:each) do
        JqUiDateSelect.format= :american
      end

      describe "when the time input is blank" do

        it "should return '%m/%d/%Y'" do
          JqUiDateSelect.date_format_string.should == "%m/%d/%Y"
        end
        
      end

      describe "when the time input is false" do

        it "should return '%m/%d/%Y'" do
          JqUiDateSelect.date_format_string(false).should == "%m/%d/%Y"
        end
        
      end

      describe "when the time input is true" do

        it "should return '%m/%d/%Y %I:%M %p'" do
          JqUiDateSelect.date_format_string(true).should == "%m/%d/%Y %I:%M %p"
        end

      end

    end

  end

  describe "Formating a date where:" do

    describe "using the default format" do

      describe "for '01/01/2001'" do

        it "should return 'January 01, 2001'" do
          JqUiDateSelect.format_date('01/01/2001'.to_date).should == "January 01, 2001"
        end

      end

      describe "for '01/01/2001 11:00 PM'" do

        it "should return 'January 01, 2001 11:00 PM'" do
          JqUiDateSelect.format_date('01/01/2001 11:00 PM'.to_time).should == "January 01, 2001 11:00 PM"
        end

      end

      describe "for '01/01/2001 11:00 PM'" do

        it "should return 'January 01, 2001 11:00 PM'" do
          JqUiDateSelect.format_date(DateTime.parse('01/01/2001 11:00 PM')).should == "January 01, 2001 11:00 PM"
        end

      end

    end

    describe "using the :american format" do

      before(:each) do
        JqUiDateSelect.format= :american
      end

      describe "for '01/01/2001'" do

        it "should return '01/01/2001'" do
          JqUiDateSelect.format_date('01/01/2001'.to_date).should == "01/01/2001"
        end

      end

      describe "for '01/01/2001 11:00 PM'" do

        it "should return '01/01/2001 11:00 PM'" do
          JqUiDateSelect.format_date('01/01/2001 11:00 PM'.to_time).should == "01/01/2001 11:00 PM"
        end

      end

      describe "for a time of 01/01/2001 11:00 PM" do

        it "should return '01/01/2001 11:00 PM'" do
          JqUiDateSelect.format_date(DateTime.parse('01/01/2001 11:00 PM')).should == "01/01/2001 11:00 PM"
        end

      end

    end

  end

  describe "The format_time function where:" do

    describe "when given 'garbage'" do

      it "should return 'garbage'" do
        JqUiDateSelect.format_time('garbage').should == 'garbage'
      end

    end

    describe "when given a date (01/01/2001) with no options" do

      it "should return 'January 01, 2001'" do
        JqUiDateSelect.format_time('01/01/2001'.to_date).should == 'January 01, 2001'
      end

    end

    describe "when given a date (01/01/2001) with options (:time => false)" do

      it "should return 'January 01, 2001'" do
        JqUiDateSelect.format_time('01/01/2001'.to_date, :time => false).should == 'January 01, 2001'
      end

    end

    describe "when given a date (01/01/2001) with options (:time => true)" do

      it "should return 'January 01, 2001'" do
        JqUiDateSelect.format_time('01/01/2001'.to_date, :time => true).should == 'January 01, 2001'
      end

    end

    describe "when given a time (01/01/2001 11:00) with options (:time => true)" do

      it "should return 'January 01, 2001 11:00 AM'" do
        JqUiDateSelect.format_time('01/01/2001 11:00 AM'.to_time, {:time => true}).should == 'January 01, 2001 11:00 AM'
      end

    end

    describe "when given a time (01/01/2001 11:00) with options (:time => false)" do

      it "should return 'January 01, 2001'" do
        JqUiDateSelect.format_time('01/01/2001 11:00 AM'.to_time, {:time => false}).should == 'January 01, 2001'
      end

    end

  end

  describe "The 'jq_ui_date_select_process_options' function" do

    describe "with :default_tim" do

      describe "equaling Time.parse('January 1, 2001 5:00 PM')" do

        it "returns {:datepicker_options => {:defaultDate => 'January 01, 2001'}, :timepicker_options => {:hour => 5, :minute => 0, :second => 0}}" do
          JqUiDateSelect.jq_ui_date_select_process_options({:default_time => Time.parse("January 1, 2001 5:00 PM")}).should ==
            {:datepicker_options => {:defaultDate => 'January 01, 2001'}, :timepicker_options => {:hour => 17, :minute => 0, :second => 0}}
        end

      end

      describe "equaling Date.parse('January 1, 2001 5:00 PM')" do

        it "returns {:datepicker_options => {:defaultDate => 'January 01, 2001'}}" do
          JqUiDateSelect.jq_ui_date_select_process_options({:default_time => Date.parse("January 1, 2001 5:00 PM")}).should ==
            {:datepicker_options => {:defaultDate => 'January 01, 2001'}}
        end

      end

      describe "equaling 'pancakes'" do

        it "returns {:datepicker_options => {:defaultDate => 'pancakes'}}" do
          JqUiDateSelect.jq_ui_date_select_process_options({:default_time => 'pancakes'}).should ==
            {:datepicker_options => {:defaultDate => 'pancakes'}}
        end

      end

    end

    describe "with :popup" do

      describe "equaling 'force'" do

        it "should return :readonly => true" do
          JqUiDateSelect.jq_ui_date_select_process_options({:popup => "force"}).should == {:readonly => true}
        end

      end

      describe "equaling :force" do

        it "should return :readonly => true" do
          JqUiDateSelect.jq_ui_date_select_process_options({:popup => :force}).should == {:readonly => true}
        end

      end

      describe "equaling 'pancakes'" do

        it "should return :readonly => true" do
          JqUiDateSelect.jq_ui_date_select_process_options({:popup => 'pancakes'}).should == {}
        end

      end

      describe "equaling :pancakes" do

        it "should return :readonly => true" do
          JqUiDateSelect.jq_ui_date_select_process_options({:popup => :pancakes}).should == {}
        end

      end

    end

    describe "with :minute_interval" do

      describe "equaling 15" do

        it "returns :timepicker_options => {:stepMinute => 15}" do
          JqUiDateSelect.jq_ui_date_select_process_options({:minute_interval => 15}).should == {:timepicker_options => {:stepMinute => 15}}
        end

      end

      describe "equaling 0.15" do

        it "returns :timepicker_options => {:stepMinute => 15}" do
          JqUiDateSelect.jq_ui_date_select_process_options({:minute_interval => 0.15}).should == {:timepicker_options => {:stepMinute => 0.15}}
        end

      end

      describe "equaling 'pancakes'" do

        it "returns {}" do
          JqUiDateSelect.jq_ui_date_select_process_options({:minute_interval => "pancakes"}).should == {}
        end

      end

    end
    
    describe "with :year_range" do
      
      describe "equals 2000..2020" do

        it "returns :datepicker_options => {:yearRange => '2000:2020'}" do
          JqUiDateSelect.jq_ui_date_select_process_options({:year_range => 2000..2020}).should == {:datepicker_options => {:yearRange => '2000:2020'}}
        end

      end

      describe "equals [2000..2020]" do

        it "returns :datepicker_options => {:yearRange => '2000:2020'}" do
          JqUiDateSelect.jq_ui_date_select_process_options({:year_range => [2000, 2020]}).should == {:datepicker_options => {:yearRange => '2000:2020'}}
        end

      end

      describe "equals 2.years.ago..2.years.from_now" do

        it "returns :datepicker_options => {:yearRange => '#{2.years.ago.strftime("%Y")}:#{2.years.from_now.strftime("%Y")}'}" do
          output = JqUiDateSelect.jq_ui_date_select_process_options({:year_range => 2.years.ago..2.years.from_now})
          output.should == {:datepicker_options => {:yearRange => "#{2.years.ago.strftime("%Y")}:#{2.years.from_now.strftime("%Y")}"}}
        end

      end

      describe "equals [2.years.ago, 2.years.from_now]" do

        it "returns :datepicker_options => {:yearRange => '#{2.years.ago.strftime("%Y")}:#{2.years.from_now.strftime("%Y")}'}" do
          output = JqUiDateSelect.jq_ui_date_select_process_options({:year_range => [2.years.ago, 2.years.from_now]})
          output.should == {:datepicker_options => {:yearRange => "#{2.years.ago.strftime("%Y")}:#{2.years.from_now.strftime("%Y")}"}}
        end

      end

      describe "equals 2.years.ago" do

        it "returns :datepicker_options => {:yearRange => '#{2.years.ago.strftime("%Y")}:#{2.year.ago.strftime("%Y")}'}" do
          output = JqUiDateSelect.jq_ui_date_select_process_options({:year_range => 2.years.ago})
          output.should == {:datepicker_options => {:yearRange => "#{2.years.ago.strftime("%Y")}:#{2.years.ago.strftime("%Y")}"}}
        end

      end

    end

    describe "with :month_year" do

      describe "equals 'pancakes'" do

        it "returns {}" do
          output = JqUiDateSelect.jq_ui_date_select_process_options(:month_year => "pancakes")
          #puts output
          output.should == {}
        end

      end

      describe "equals 'dropdowns'" do

        it "returns :datepicker_options => {:changeMonth => true, :changeYear => true}" do
          output = JqUiDateSelect.jq_ui_date_select_process_options({:month_year => "dropdowns"})
          output.should == {:datepicker_options => {:changeMonth => true, :changeYear => true}}
        end

      end

      describe "equals 'labels'" do

        it "returns :datepicker_options => {:changeMonth => true, :changeYear => true}" do
          output = JqUiDateSelect.jq_ui_date_select_process_options({:month_year => "labels"})
          output.should == {:datepicker_options => {:changeMonth => false, :changeYear => false}}
        end

      end

    end

    #describe "with :image" do

      #describe "equals 'groovy.png'" do

        #it "returns :datepicker_options => {:buttonImage => '/images/groovy.png', :buttonImageOnly => true}" do
          #output = JqUiDateSelect.jq_ui_date_select_process_options({:image => 'groovy.png'})
          #output.should == {:datepicker_options => {:buttonImage => '/images/groovy.png', :buttonImageOnly => true}}
        #end

      #end

      #describe "equals 'http://www.google.com/images/MindControl.gif'" do

        #it "reuturns :datepicker_options => {:buttonImage => 'http://www.google.com/images/MindControl.gif', :buttonImageOnly => true}" do
          #output = JqUiDateSelect.jq_ui_date_select_process_options({:image => 'http://www.google.com/images/MindControl.gif'})
          #output.should == {:datepicker_options => {:buttonImage => 'http://www.google.com/images/MindControl.gif', :buttonImageOnly => true}}
        #end
          
      #end

    #end

  end

end
