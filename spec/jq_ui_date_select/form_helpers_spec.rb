require File.dirname(__FILE__) + '/../spec_helper'

describe JqUiDateSelect::FormHelpers do
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::JavaScriptHelper
  
  include JqUiDateSelect::FormHelpers

  before(:each) do
    JqUiDateSelect.instance_variable_set :@jq_ui_date_select_format, nil
  end

  describe "The jq_ui_date_select function" do

    describe "with a model of 'task' with a 'deadline' field" do

      before(:each) do
        @task = OpenStruct.new
        @task.deadline = nil
      end

      describe "with deadline unassigned" do

        it "returns and input with a class of 'jq_ui_ds_dp' for the 'deadline' field with no value" do
          output = jq_ui_date_select(:task, :deadline)
          output.should == text_field(:task, :deadline, :class => "jq_ui_ds_dp")
        end
        
      end

      describe "with deadline assigned as a date" do

        before(:each) do
          @task.deadline = "01/02/2001".to_date
        end
        
        it "returns and input with a class of 'jq_ui_ds_dp' for the 'deadline' field with a value formated to 'January 02, 2001'" do
          output = jq_ui_date_select(:task, :deadline)
          output.should == text_field(:task, :deadline, :class => "jq_ui_ds_dp", :value => "January 02, 2001")
        end

        describe "with a format of :finnish" do

          it "returns and input with a class of 'jq_ui_ds_dp' for the 'deadline' field with a value formated to '02.01.2001'" do
            JqUiDateSelect.format=(:finnish)
            output = jq_ui_date_select(:task, :deadline)
            output.should == text_field(:task, :deadline, :class => "jq_ui_ds_dp", :value => "02.01.2001")
          end

        end

        describe "with datepicker_options of '{:autoSize => true}'" do

          it "returns and input with a class of 'jq_ui_ds_dp' for the 'deadline' field," + 
          " a value formated to 'January 02, 2001'," +
          " and a data-jqdatepicker value of '{\"autoSize\":true}'" do
            output = jq_ui_date_select(:task, :deadline, :datepicker_options => {:autoSize => true})
            output.should == text_field(:task, :deadline, :class => "jq_ui_ds_dp", :value => "January 02, 2001", "data-jqdatepicker" => '{"autoSize":true}' )
          end

        end

        describe ":year_range set to [2000..2020]" do

          it "returns and input with a class of 'jq_ui_ds_dp' for the 'deadline' field," + 
          " a value formated to 'January 02, 2001'," +
          " and a data-jqdatepicker value of '{\"yearRange\":\"2000:2020\"}'" do
            output = jq_ui_date_select(:task, :deadline, :year_range => 2000..2020 )
            output.should == text_field(:task, :deadline, :class => "jq_ui_ds_dp", :value => "January 02, 2001", "data-jqdatepicker" => '{"yearRange":"2000:2020"}' )
          end

        end

        describe "with a differnt object passed in the options hash" do

          before(:each) do
            @task2 = OpenStruct.new
            @task2.deadline = "01/03/2001".to_date
          end

          it "returns and input with a class of 'jq_ui_ds_dp' for the 'deadline' field with a value formated to 'January 02, 2001'" do
            output = jq_ui_date_select(:task, :deadline, :object => @task2)
            output.should == text_field(:task, :deadline, :class => "jq_ui_ds_dp", :value => "January 03, 2001")
          end

        end

      end

      describe "with deadline assigned as a time" do

        before(:each) do
          @task.deadline = Time.parse("01/02/2001")
        end
        
        it "returns and input with a class of 'jq_ui_ds_dp' for the 'deadline' field with a value formated to 'January 02, 2001'" do
          output = jq_ui_date_select(:task, :deadline)
          output.should == text_field(:task, :deadline, :class => "jq_ui_ds_dp", :value => "January 02, 2001")
        end

        describe "with a :time => true" do
          
        end

        describe "with a format of :finnish" do

          it "returns and input with a class of 'jq_ui_ds_dp' for the 'deadline' field with a value formated to '02.01.2001'" do
            JqUiDateSelect.format=(:finnish)
            output = jq_ui_date_select(:task, :deadline)
            output.should == text_field(:task, :deadline, :class => "jq_ui_ds_dp", :value => "02.01.2001")
          end

        end

        describe "with datepicker_options of '{:autoSize => true}'" do

          it "returns and input with a class of 'jq_ui_ds_dp' for the 'deadline' field," + 
          " a value formated to 'January 02, 2001'," +
          " and a data-jqdatepicker value of '{\"autoSize\":true}'" do
            output = jq_ui_date_select(:task, :deadline, :datepicker_options => {:autoSize => true})
            output.should == text_field(:task, :deadline, :class => "jq_ui_ds_dp", :value => "January 02, 2001", "data-jqdatepicker" => '{"autoSize":true}' )
          end

        end

        describe ":year_range set to [2000..2020]" do

          it "returns and input with a class of 'jq_ui_ds_dp' for the 'deadline' field," + 
          " a value formated to 'January 02, 2001'," +
          " and a data-jqdatepicker value of '{\"yearRange\":\"2000:2020\"}'" do
            output = jq_ui_date_select(:task, :deadline, :year_range => 2000..2020 )
            output.should == text_field(:task, :deadline, :class => "jq_ui_ds_dp", :value => "January 02, 2001", "data-jqdatepicker" => '{"yearRange":"2000:2020"}' )
          end

        end

        describe "with a differnt object passed in the options hash" do

          before(:each) do
            @task2 = OpenStruct.new
            @task2.deadline = "01/03/2001".to_date
          end

          it "returns and input with a class of 'jq_ui_ds_dp' for the 'deadline' field with a value formated to 'January 02, 2001'" do
            output = jq_ui_date_select(:task, :deadline, :object => @task2)
            output.should == text_field(:task, :deadline, :class => "jq_ui_ds_dp", :value => "January 03, 2001")
          end

        end

      end

    end

  end

  describe "The jq_ui_date_select_tag function" do

    describe "with only a name of 'date'" do
      
      it "should return an input with a class of 'jq_ui_ds_dp' and a name of 'date'" do
        jq_ui_date_select_tag("date").should == text_field_tag("date", nil, :class => "jq_ui_ds_dp")
      end

    end

    describe "with a name of 'date' and a value of '01/01/2001'" do

      it "returns an input with a class of 'jq_ui_ds_dp', a name of 'date', and a value of 'January 01, 2001'" do
        jq_ui_date_select_tag("date", "01/01/2001".to_date).should == text_field_tag("date", "January 01, 2001", :class => "jq_ui_ds_dp")
      end

      describe "with a format of :finnish" do

        it "returns a inputs with a class of 'jq_ui_ds_dp', a name of 'date', and a value of '01.01.2001'" do
          JqUiDateSelect.format=(:finnish)
          jq_ui_date_select_tag("date", "01/01/2001".to_date).should == text_field_tag("date", "01.01.2001", :class => "jq_ui_ds_dp")
        end
        
      end

    end

    describe "with a name of 'date' and a class of 'date_input'" do

      it "returns an input with a class of 'date_input jq_ui_ds_dp' and a name of 'date'" do
        jq_ui_date_select_tag("date", nil, :class => "date_input").should == text_field_tag("date", nil, :class => "date_input jq_ui_ds_dp")
      end
      
    end

    describe "with a name of 'date' and datepicker_options of '{:autoSize => true}'" do

      it "returns an input with a name of 'date' and a data-jqdatepicker value of '{\"autoSize\":true}'" do
        jq_ui_date_select_tag("date", nil, :datepicker_options => {:autoSize => true}).should == text_field_tag("date", nil, "data-jqdatepicker" => '{"autoSize":true}', :class => "jq_ui_ds_dp")
      end

    end

    describe "with a name of 'date' and :year_range of 2000..2020" do

      it "returns an input with a name of 'date' and a data-jqdatepicker value of '{\"yearRange\":\"2000:2020\"}'" do
        jq_ui_date_select_tag("date", nil, :year_range => 2000..2020).should == text_field_tag("date", nil, "data-jqdatepicker" => '{"yearRange":"2000:2020"}', :class => "jq_ui_ds_dp")
      end

    end

  end

end
