require File.dirname(__FILE__) + '/../spec_helper'

describe JqUiDateSelect::FormHelpers do
  #include ActionView::Helpers::FormHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::FormTagHelper
  
  include JqUiDateSelect::FormHelpers

  describe "The jq_ui_date_select_tag function" do

    describe "with only a name of 'date'" do
      
      it "should return an input with a class of 'jq_ui_dp' and a name of 'date'" do
        jq_ui_date_select_tag("date").should == text_field_tag("date", nil, :class => "jq_ui_dp_ds")
      end

    end

    describe "with a name of 'date' and a value of '01/01/2001'" do

      it "returns an input with a class of 'jq_ui_dp', a name of 'date', and a value of 'January 01, 2001'" do
        jq_ui_date_select_tag("date", "01/01/2001".to_date).should == text_field_tag("date", "January 01, 2001", :class => "jq_ui_dp_ds")
      end

      describe "with a format of :finnish" do

        it "returns a inputs with a class of 'jq_ui_dp', a name of 'date', and a value of '01.01.2001'" do
          JqUiDateSelect.format=(:finnish)
          jq_ui_date_select_tag("date", "01/01/2001".to_date).should == text_field_tag("date", "01.01.2001", :class => "jq_ui_dp_ds")
        end
        
      end

    end

    describe "with a name of 'date' and a class of 'date_input'" do

      it "returns an input with a class of 'date_input jq_ui_dp' and a name of 'date'" do
        jq_ui_date_select_tag("date", nil, :class => "date_input").should == text_field_tag("date", nil, :class => "date_input jq_ui_dp_ds")
      end
      
    end

    describe "with a name of 'date' and datepicker_options of '{:autoSize => true}'" do

      it "returns an input with a name of 'date' and a data-jqdatepicker value of '{\"autoSize\":true}'" do
        jq_ui_date_select_tag("date", nil, :datepicker_options => {:autoSize => true}).should == text_field_tag("date", nil, "data-jqdatepicker" => '{"autoSize":true}', :class => "jq_ui_dp_ds")
      end

    end

  end

end
