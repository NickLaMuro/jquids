require File.dirname(__FILE__) + '/../spec_helper'

describe Jquids do
  include ActionView::Helpers::AssetTagHelper
  include Jquids

  before(:each) do
    Jquids.instance_variable_set :@jquids_format, nil
  end

  describe "The format function where:" do
    
    describe "The default format" do
   
      it "should return the natural format" do
        Jquids.format.should == {:date => "%B %d, %Y", :time => " %I:%M %p", :js_date => "MM dd, yy", :tr_js_time => "hh:mm TT", :ampm => true}
      end

    end

    describe "Setting the format" do

      describe "with an invalid key" do

        it "should raise an Jquids::NotAKnownFormat error" do
          expect{ Jquids.format=(:not_a_valid_key) }.to raise_error(Jquids::NotAKnownFormat, "Jquids: Unrecognized format specification: not_a_valid_key")
        end

      end

      Jquids::FORMATS.each do |format|

        describe "to '#{format[0]}'" do

          it "should start with a default of 'natural' format" do
            Jquids.format.should == {:date => "%B %d, %Y", :time => " %I:%M %p", :js_date => "MM dd, yy", :tr_js_time => "hh:mm TT", :ampm => true}
          end

          it "should set the format to '#{format[0]}' when 'format=' is called" do
            Jquids.format=(format[0])
            Jquids.format.should == format[1]
          end

        end

      end

    end

  end

  describe "The date_format_string function where:" do

    describe "The format is the default state" do

      describe "when the time input is blank" do

        it "should return '%B %d, %Y'" do
          Jquids.date_format_string.should == "%B %d, %Y"          
        end
        
      end

      describe "when the time input is false" do

        it "should return '%B %d, %Y'" do
          Jquids.date_format_string(false).should == "%B %d, %Y"          
        end
        
      end

      describe "when the time input is true" do

        it "should return '%B %d, %Y %I:%M %p'" do
          Jquids.date_format_string(true).should == "%B %d, %Y %I:%M %p"
        end
        
      end
      
    end

    describe "The format is set to ':american'" do

      before(:each) do
        Jquids.format= :american
      end

      describe "when the time input is blank" do

        it "should return '%m/%d/%Y'" do
          Jquids.date_format_string.should == "%m/%d/%Y"
        end
        
      end

      describe "when the time input is false" do

        it "should return '%m/%d/%Y'" do
          Jquids.date_format_string(false).should == "%m/%d/%Y"
        end
        
      end

      describe "when the time input is true" do

        it "should return '%m/%d/%Y %I:%M %p'" do
          Jquids.date_format_string(true).should == "%m/%d/%Y %I:%M %p"
        end

      end

    end

  end

  describe "Formating a date where:" do

    describe "using the default format" do

      describe "for '01/01/2001'" do

        it "should return 'January 01, 2001'" do
          Jquids.format_date('01/01/2001'.to_date).should == "January 01, 2001"
        end

      end

      describe "for '01/01/2001 11:00 PM'" do

        it "should return 'January 01, 2001 11:00 PM'" do
          Jquids.format_date('01/01/2001 11:00 PM'.to_time).should == "January 01, 2001 11:00 PM"
        end

      end

      describe "for '01/01/2001 11:00 PM'" do

        it "should return 'January 01, 2001 11:00 PM'" do
          Jquids.format_date(DateTime.parse('01/01/2001 11:00 PM')).should == "January 01, 2001 11:00 PM"
        end

      end

    end

    describe "using the :american format" do

      before(:each) do
        Jquids.format= :american
      end

      describe "for '01/01/2001'" do

        it "should return '01/01/2001'" do
          Jquids.format_date('01/01/2001'.to_date).should == "01/01/2001"
        end

      end

      describe "for '01/01/2001 11:00 PM'" do

        it "should return '01/01/2001 11:00 PM'" do
          Jquids.format_date('01/01/2001 11:00 PM'.to_time).should == "01/01/2001 11:00 PM"
        end

      end

      describe "for a time of 01/01/2001 11:00 PM" do

        it "should return '01/01/2001 11:00 PM'" do
          Jquids.format_date(DateTime.parse('01/01/2001 11:00 PM')).should == "01/01/2001 11:00 PM"
        end

      end

    end

  end

  describe "The format_time function where:" do

    describe "when given 'garbage'" do

      it "should return 'garbage'" do
        Jquids.format_time('garbage').should == 'garbage'
      end

    end

    describe "when given a date (01/01/2001) with no options" do

      it "should return 'January 01, 2001'" do
        Jquids.format_time('01/01/2001'.to_date).should == 'January 01, 2001'
      end

    end

    describe "when given a date (01/01/2001) with options (:time => false)" do

      it "should return 'January 01, 2001'" do
        Jquids.format_time('01/01/2001'.to_date, :time => false).should == 'January 01, 2001'
      end

    end

    describe "when given a date (01/01/2001) with options (:time => true)" do

      it "should return 'January 01, 2001'" do
        Jquids.format_time('01/01/2001'.to_date, :time => true).should == 'January 01, 2001'
      end

    end

    describe "when given a time (01/01/2001 11:00) with options (:time => true)" do

      it "should return 'January 01, 2001 11:00 AM'" do
        Jquids.format_time('01/01/2001 11:00 AM'.to_time, {:time => true}).should == 'January 01, 2001 11:00 AM'
      end

    end

    describe "when given a time (01/01/2001 11:00) with options (:time => false)" do

      it "should return 'January 01, 2001'" do
        Jquids.format_time('01/01/2001 11:00 AM'.to_time, {:time => false}).should == 'January 01, 2001'
      end

    end

  end

  describe "The 'jquids_process_options' function" do

    describe "with :default_tim" do

      describe "equaling Time.parse('January 1, 2001 5:00 PM')" do

        it "returns {:datepicker_options => {:defaultDate => 'January 01, 2001'}, :timepicker_options => {:hour => 5, :minute => 0, :second => 0}}" do
          Jquids.jquids_process_options({:default_time => Time.parse("January 1, 2001 5:00 PM")}).should ==
            {:datepicker_options => {:defaultDate => 'January 01, 2001'}, :timepicker_options => {:hour => 17, :minute => 0, :second => 0}}
        end

      end

      describe "equaling Date.parse('January 1, 2001 5:00 PM')" do

        it "returns {:datepicker_options => {:defaultDate => 'January 01, 2001'}}" do
          Jquids.jquids_process_options({:default_time => Date.parse("January 1, 2001 5:00 PM")}).should ==
            {:datepicker_options => {:defaultDate => 'January 01, 2001'}}
        end

      end

      describe "equaling 'pancakes'" do

        it "returns {:datepicker_options => {:defaultDate => 'pancakes'}}" do
          Jquids.jquids_process_options({:default_time => 'pancakes'}).should ==
            {:datepicker_options => {:defaultDate => 'pancakes'}}
        end

      end

    end

    describe "with :popup" do

      describe "equaling 'force'" do

        it "should return :readonly => true" do
          Jquids.jquids_process_options({:popup => "force"}).should == {:readonly => true}
        end

      end

      describe "equaling :force" do

        it "should return :readonly => true" do
          Jquids.jquids_process_options({:popup => :force}).should == {:readonly => true}
        end

      end

      describe "equaling 'pancakes'" do

        it "should return :readonly => true" do
          Jquids.jquids_process_options({:popup => 'pancakes'}).should == {}
        end

      end

      describe "equaling :pancakes" do

        it "should return :readonly => true" do
          Jquids.jquids_process_options({:popup => :pancakes}).should == {}
        end

      end

    end

    describe "with :minute_interval" do

      describe "equaling 15" do

        it "returns :timepicker_options => {:stepMinute => 15}" do
          Jquids.jquids_process_options({:minute_interval => 15}).should == {:timepicker_options => {:stepMinute => 15}}
        end

      end

      describe "equaling 0.15" do

        it "returns :timepicker_options => {:stepMinute => 15}" do
          Jquids.jquids_process_options({:minute_interval => 0.15}).should == {:timepicker_options => {:stepMinute => 0.15}}
        end

      end

      describe "equaling 'pancakes'" do

        it "returns {}" do
          Jquids.jquids_process_options({:minute_interval => "pancakes"}).should == {}
        end

      end

    end
    
    describe "with :year_range" do
      
      describe "equals 2000..2020" do

        it "returns :datepicker_options => {:yearRange => '2000:2020'}" do
          Jquids.jquids_process_options({:year_range => 2000..2020}).should == {:datepicker_options => {:yearRange => '2000:2020'}}
        end

      end

      describe "equals [2000..2020]" do

        it "returns :datepicker_options => {:yearRange => '2000:2020'}" do
          Jquids.jquids_process_options({:year_range => [2000, 2020]}).should == {:datepicker_options => {:yearRange => '2000:2020'}}
        end

      end

      describe "equals 2.years.ago..2.years.from_now" do

        it "returns :datepicker_options => {:yearRange => '#{2.years.ago.strftime("%Y")}:#{2.years.from_now.strftime("%Y")}'}" do
          output = Jquids.jquids_process_options({:year_range => 2.years.ago..2.years.from_now})
          output.should == {:datepicker_options => {:yearRange => "#{2.years.ago.strftime("%Y")}:#{2.years.from_now.strftime("%Y")}"}}
        end

      end

      describe "equals [2.years.ago, 2.years.from_now]" do

        it "returns :datepicker_options => {:yearRange => '#{2.years.ago.strftime("%Y")}:#{2.years.from_now.strftime("%Y")}'}" do
          output = Jquids.jquids_process_options({:year_range => [2.years.ago, 2.years.from_now]})
          output.should == {:datepicker_options => {:yearRange => "#{2.years.ago.strftime("%Y")}:#{2.years.from_now.strftime("%Y")}"}}
        end

      end

      describe "equals 2.years.ago" do

        it "returns :datepicker_options => {:yearRange => '#{2.years.ago.strftime("%Y")}:#{2.year.ago.strftime("%Y")}'}" do
          output = Jquids.jquids_process_options({:year_range => 2.years.ago})
          output.should == {:datepicker_options => {:yearRange => "#{2.years.ago.strftime("%Y")}:#{2.years.ago.strftime("%Y")}"}}
        end

      end

    end

    describe "with :month_year" do

      describe "equals 'pancakes'" do

        it "returns {}" do
          output = Jquids.jquids_process_options(:month_year => "pancakes")
          #puts output
          output.should == {}
        end

      end

      describe "equals 'dropdowns'" do

        it "returns :datepicker_options => {:changeMonth => true, :changeYear => true}" do
          output = Jquids.jquids_process_options({:month_year => "dropdowns"})
          output.should == {:datepicker_options => {:changeMonth => true, :changeYear => true}}
        end

      end

      describe "equals 'labels'" do

        it "returns :datepicker_options => {:changeMonth => true, :changeYear => true}" do
          output = Jquids.jquids_process_options({:month_year => "labels"})
          output.should == {:datepicker_options => {:changeMonth => false, :changeYear => false}}
        end

      end

    end

    describe "with :image" do

      describe "equals 'groovy.png'" do

        it "returns :datepicker_options => {:buttonImage => '/images/groovy.png', :buttonImageOnly => true}" do
          output = Jquids.jquids_process_options({:image => 'groovy.png'})
          output.should == {:datepicker_options => {:buttonImage => '/images/groovy.png', :buttonImageOnly => true, :showOn => "button"}}
        end

        describe "with :datepicker_options => {:showOn} already set" do

          it "returns :datepicker_options => {:buttonImage => '/images/groovy.png', :buttonImageOnly => true}" do
            output = Jquids.jquids_process_options({:image => 'groovy.png', :datepicker_options => {:showOn => "both"}})
            output.should == {:datepicker_options => {:buttonImage => '/images/groovy.png', :buttonImageOnly => true, :showOn => "both"}}
          end

        end

      end

      describe "equals 'http://www.google.com/images/MindControl.gif'" do

        it "reuturns :datepicker_options => {:buttonImage => 'http://www.google.com/images/MindControl.gif', :buttonImageOnly => true}" do
          output = Jquids.jquids_process_options({:image => 'http://www.google.com/images/MindControl.gif'})
          output.should == {:datepicker_options => {:buttonImage => 'http://www.google.com/images/MindControl.gif', :buttonImageOnly => true, :showOn => 'button'}}
        end
          
      end

    end

  end

end
