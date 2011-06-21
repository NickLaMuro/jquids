require File.dirname(__FILE__) + '/../spec_helper'

describe "CalendarDateSelect" do

  describe "The format function where:" do
    
    describe "The default format" do
   
      it "should return the natural format" do
        JqUiDateSelect.format.should == {:date => "%B %d, %Y", :time => " %I:%M %p", :js_date => "MM dd, yy"}
      end

    end

    describe "Setting the format" do

      describe "with an invalid key" do

        it "should raise an JqUiDateSelect::NotAKnownFormat error" do
          expect{ JqUiDateSelect.format=(:not_a_valid_key) }.to raise_error(JqUiDateSelect::NotAKnownFormat, "JqUiDateSelect: Unrecognized format specification: not_a_valid_key")
        end

      end

      FORMATS.each do |format|

        describe "to '#{format[0]}'" do

          it "should start with a default of 'natural' format" do
            JqUiDateSelect.format.should == {:date => "%B %d, %Y", :time => " %I:%M %p", :js_date => "MM dd, yy"}
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

      describe "for '01/01/2001 11:00 PM'" do

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

  after(:each) do
    JqUiDateSelect.instance_variable_set :@jq_ui_date_select_format, nil
  end

end
