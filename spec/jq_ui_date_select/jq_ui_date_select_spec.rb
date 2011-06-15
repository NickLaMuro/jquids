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

        it "should raise an error" do
          expect{ JqUiDateSelect.format=(:not_a_valid_key) }.to raise_error(JqUiDateSelect::NotAKnownFormat, "JqUiDateSelect: Unrecognized format specification: not_a_valid_key")
        end

      end

      describe "to 'hyphen_ampm'" do

        it "should start with a default of 'natural' format" do
          JqUiDateSelect.format.should == {:date => "%B %d, %Y", :time => " %I:%M %p", :js_date => "MM dd, yy"}
        end

        it "should set the format to 'hyphen_ampm' when 'format=' is called" do
          JqUiDateSelect.format=(:hyphen_ampm)
          JqUiDateSelect.format.should == {:date => "%Y-%m-%d", :time => " %I:%M %p", :js_date => "yy-mm-dd"}
        end

      end

      describe "to 'iso_date'" do

        it "should start with a default of 'natural' format" do
          JqUiDateSelect.format.should == {:date => "%B %d, %Y", :time => " %I:%M %p", :js_date => "MM dd, yy"}
        end
 
        it "should set the format to 'iso_date' when 'format=' is called" do
          JqUiDateSelect.format=(:iso_date)
          JqUiDateSelect.format.should == {:date => "%Y-%m-%d", :time => " %H:%M", :js_date => "yy-mm-dd"}
        end
  
      end

      describe "to 'finnish'" do

        it "should start with a default of 'natural' format" do
          JqUiDateSelect.format.should == {:date => "%B %d, %Y", :time => " %I:%M %p", :js_date => "MM dd, yy"}
        end

        it "should set the format to 'finnish' when 'format=' is called" do
          JqUiDateSelect.format=(:finnish)
          JqUiDateSelect.format.should == {:date => "%d.%m.%Y", :time => " %H:%M", :js_date => "dd.mm.yy"}
        end

      end

      describe "to 'danish'" do

        it "should start with a default of 'natural' format" do
          JqUiDateSelect.format.should == {:date => "%B %d, %Y", :time => " %I:%M %p", :js_date => "MM dd, yy"}
        end

        it "should set the format to 'danish' when 'format=' is called" do
          JqUiDateSelect.format=(:danish)
          JqUiDateSelect.format.should == {:date => "%d/%m/%Y", :time => " %H:%M", :js_date => "dd/mm/yy"}
        end

      end

      describe "to 'american'" do

        it "should start with a default of 'natural' format" do
          JqUiDateSelect.format.should == {:date => "%B %d, %Y", :time => " %I:%M %p", :js_date => "MM dd, yy"}
        end

        it "should set the format to 'american' when 'format=' is called" do
          JqUiDateSelect.format=(:american)
          JqUiDateSelect.format.should == {:date => "%m/%d/%Y", :time => " %I:%M %p", :js_date => "mm/dd/yy"}
        end

      end

      describe "to 'euro_24hr'" do

        it "should start with a default of 'natural' format" do
          JqUiDateSelect.format.should == {:date => "%B %d, %Y", :time => " %I:%M %p", :js_date => "MM dd, yy"}
        end

        it "should set the format to 'euro_24hr' when 'format=' is called" do
          JqUiDateSelect.format=(:euro_24hr)
          JqUiDateSelect.format.should == {:date => "%d %B %Y", :time => " %H:%M", :js_date => "dd MM yy"}
        end

      end

      describe "to 'euro_24hr_ymd'" do

        it "should start with a default of 'natural' format" do
          JqUiDateSelect.format.should == {:date => "%B %d, %Y", :time => " %I:%M %p", :js_date => "MM dd, yy"}
        end

        it "should set the format to 'euro_24hr_ymd' when 'format=' is called" do
          JqUiDateSelect.format=(:euro_24hr_ymd)
          JqUiDateSelect.format.should == {:date => "%Y.%m.%d", :time => " %H:%M", :js_date => "yy.mm.dd"}
        end

      end

      describe "to 'italian'" do

        it "should start with a default of 'natural' format" do
          JqUiDateSelect.format.should == {:date => "%B %d, %Y", :time => " %I:%M %p", :js_date => "MM dd, yy"}
        end

        it "should set the format to 'italian' when 'format=' is called" do
          JqUiDateSelect.format=(:italian)
          JqUiDateSelect.format.should == {:date => "%d/%m/%Y", :time => " %H:%M", :js_date => "dd/mm/yy"}
        end

      end

      describe "to 'db'" do

        it "should start with a default of 'natural' format" do
          JqUiDateSelect.format.should == {:date => "%B %d, %Y", :time => " %I:%M %p", :js_date => "MM dd, yy"}
        end

        it "should set the format to 'db' when 'format=' is called" do
          JqUiDateSelect.format=(:db)
          JqUiDateSelect.format.should == {:date => "%Y-%m-%d", :time => " %H:%M", :js_date => "yy-mm-dd"}
        end

      end

      after(:each) do
        JqUiDateSelect.format= :natural
      end

    end

  end

end
