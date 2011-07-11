require File.dirname(__FILE__) + '/../spec_helper'

describe Jquids::FormHelpers do

  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::JavaScriptHelper
  
  include Jquids::FormHelpers

  before(:each) do
    Jquids.instance_variable_set :@jquids_format, nil
  end

  describe "The jquids function" do

    describe "with a model of 'task' with a 'deadline' field" do

      before(:each) do
        @task = OpenStruct.new
        @task.deadline = nil
      end

      describe "with deadline unassigned" do

        it "returns and input with a class of 'jquids_dp' for the 'deadline' field with no value" do
          output = jquids(:task, :deadline)
          output.should == text_field(:task, :deadline, :class => "jquids_dp")
        end
        
      end

      describe "with deadline assigned as a date" do

        before(:each) do
          @task.deadline = "01/02/2001".to_date
        end
        
        it "returns and input with a class of 'jquids_dp' for the 'deadline' field with a value formated to 'January 02, 2001'" do
          output = jquids(:task, :deadline)
          output.should == text_field(:task, :deadline, :class => "jquids_dp", :value => "January 02, 2001")
        end

        describe "with a format of :finnish" do

          it "returns and input with a class of 'jquids_dp' for the 'deadline' field with a value formated to '02.01.2001'" do
            Jquids.format=(:finnish)
            output = jquids(:task, :deadline)
            output.should == text_field(:task, :deadline, :class => "jquids_dp", :value => "02.01.2001")
          end

        end

        describe "with datepicker_options of '{:autoSize => true}'" do

          it "returns and input with a class of 'jquids_dp' for the 'deadline' field," + 
          " a value formated to 'January 02, 2001'," +
          " and a data-jquipicker value of '{\"autoSize\":true}'" do
            output = jquids(:task, :deadline, :datepicker_options => {:autoSize => true})
            output.should == text_field(:task, :deadline, :class => "jquids_dp", :value => "January 02, 2001", "data-jquipicker" => '{"autoSize":true}' )
          end

        end

        describe ":year_range set to [2000..2020]" do

          it "returns and input with a class of 'jquids_dp' for the 'deadline' field," + 
          " a value formated to 'January 02, 2001'," +
          " and a data-jquipicker value of '{\"yearRange\":\"2000:2020\"}'" do
            output = jquids(:task, :deadline, :year_range => 2000..2020 )
            output.should == text_field(:task, :deadline, :class => "jquids_dp", :value => "January 02, 2001", "data-jquipicker" => '{"yearRange":"2000:2020"}' )
          end

        end

        describe ":time equaling true" do
          it "returns and input with a class of 'jquids_dtp' for the 'deadline' field with a value formated to 'January 02, 2001'" do
            output = jquids(:task, :deadline, :time => true)
            output.should == text_field(:task, :deadline, :class => "jquids_dtp", :value => "January 02, 2001")
          end
        end

        describe "with a differnt object passed in the options hash" do

          before(:each) do
            @task2 = OpenStruct.new
            @task2.deadline = "01/03/2001".to_date
          end

          it "returns and input with a class of 'jquids_dp' for the 'deadline' field with a value formated to 'January 02, 2001'" do
            output = jquids(:task, :deadline, :object => @task2)
            output.should == text_field(:task, :deadline, :class => "jquids_dp", :value => "January 03, 2001")
          end

        end

      end

      describe "with deadline assigned as a time" do

        before(:each) do
          @task.deadline = Time.parse("01/02/2001")
        end
        
        it "returns and input with a class of 'jquids_dp' for the 'deadline' field with a value formated to 'January 02, 2001'" do
          output = jquids(:task, :deadline)
          output.should == text_field(:task, :deadline, :class => "jquids_dp", :value => "January 02, 2001")
        end

        describe ":time equaling true" do

          it "returns and input with a class of 'jquids_dtp' for the 'deadline' field with a value formated to 'January 02, 2001'" do
            output = jquids(:task, :deadline, :time => true)
            output.should == text_field(:task, :deadline, :class => "jquids_dtp", :value => "January 02, 2001")
          end

        end

        describe ":time equaling true and :timepicker_options => {:minuteGrid => 10}" do

          it "returns an input for the 'deadline' field with a class of 'jquids_dtp'," +
            " a value formated to 'January 02, 2001'," + 
            " and a data-jquipicker with a value of '{\"minuteGrid\"10}'" do
            output = jquids(:task, :deadline, :time => true, :timepicker_options => {:minuteGrid => 10})
            output.should == text_field(:task, :deadline, :class => "jquids_dtp", :value => "January 02, 2001", "data-jquipicker" => '{"minuteGrid":10}')
          end

        end

        describe "with a format of :finnish" do

          it "returns an input for the 'deadline' field with a class of 'jquids_dp' and a value formated to '02.01.2001'" do
            Jquids.format=(:finnish)
            output = jquids(:task, :deadline)
            output.should == text_field(:task, :deadline, :class => "jquids_dp", :value => "02.01.2001")
          end

        end

        describe "with datepicker_options of '{:autoSize => true}'" do

          it "returns and input with a class of 'jquids_dp' for the 'deadline' field," + 
          " a value formated to 'January 02, 2001'," +
          " and a data-jquipicker value of '{\"autoSize\":true}'" do
            output = jquids(:task, :deadline, :datepicker_options => {:autoSize => true})
            output.should == text_field(:task, :deadline, :class => "jquids_dp", :value => "January 02, 2001", "data-jquipicker" => '{"autoSize":true}' )
          end

        end

        describe ":year_range set to [2000..2020]" do

          it "returns and input with a class of 'jquids_dp' for the 'deadline' field," + 
          " a value formated to 'January 02, 2001'," +
          " and a data-jquipicker value of '{\"yearRange\":\"2000:2020\"}'" do
            output = jquids(:task, :deadline, :year_range => 2000..2020 )
            output.should == text_field(:task, :deadline, :class => "jquids_dp", :value => "January 02, 2001", "data-jquipicker" => '{"yearRange":"2000:2020"}' )
          end

        end

        describe "with a differnt object passed in the options hash" do

          before(:each) do
            @task2 = OpenStruct.new
            @task2.deadline = "01/03/2001".to_date
          end

          it "returns and input with a class of 'jquids_dp' for the 'deadline' field with a value formated to 'January 02, 2001'" do
            output = jquids(:task, :deadline, :object => @task2)
            output.should == text_field(:task, :deadline, :class => "jquids_dp", :value => "January 03, 2001")
          end

        end

      end

    end

  end

  describe "The jquids_tag function" do

    describe "with only a name of 'date'" do
      
      it "should return an input with a class of 'jquids_dp' and a name of 'date'" do
        jquids_tag("date").should == text_field_tag("date", nil, :class => "jquids_dp")
      end

    end

    describe "with a name of 'date' and :time = true" do

      it "returns a input with a class of 'jquids_dtp' and a name of 'date'" do
        jquids_tag("date", nil, :time => true).should == text_field_tag("date", nil, :class => "jquids_dtp")
      end

    end

    describe "with a name of 'date' and :time = true" do

      it "returns a input with a class of 'jquids_dtp' and a name of 'date'" do
        jquids_tag("date", nil, :time => true, :timepicker_options => {:minuteGrid => 10}).should == text_field_tag("date", nil, :class => "jquids_dtp", "data-jquipicker" => '{"minuteGrid":10}')
      end

    end

    describe "with a name of 'date' and a value of '01/01/2001'" do

      it "returns an input with a class of 'jquids_dp', a name of 'date', and a value of 'January 01, 2001'" do
        jquids_tag("date", "01/01/2001".to_date).should == text_field_tag("date", "January 01, 2001", :class => "jquids_dp")
      end

      describe "with a format of :finnish" do

        it "returns a inputs with a class of 'jquids_dp', a name of 'date', and a value of '01.01.2001'" do
          Jquids.format=(:finnish)
          jquids_tag("date", "01/01/2001".to_date).should == text_field_tag("date", "01.01.2001", :class => "jquids_dp")
        end
        
      end

    end

    describe "with a name of 'date' and a class of 'date_input'" do

      it "returns an input with a class of 'date_input jquids_dp' and a name of 'date'" do
        jquids_tag("date", nil, :class => "date_input").should == text_field_tag("date", nil, :class => "date_input jquids_dp")
      end
      
    end

    describe "with a name of 'date' and datepicker_options of '{:autoSize => true}'" do

      it "returns an input with a name of 'date' and a data-jquipicker value of '{\"autoSize\":true}'" do
        jquids_tag("date", nil, :datepicker_options => {:autoSize => true}).should == text_field_tag("date", nil, "data-jquipicker" => '{"autoSize":true}', :class => "jquids_dp")
      end

    end

    describe "with a name of 'date' and :year_range of 2000..2020" do

      it "returns an input with a name of 'date' and a data-jquipicker value of '{\"yearRange\":\"2000:2020\"}'" do
        jquids_tag("date", nil, :year_range => 2000..2020).should == text_field_tag("date", nil, "data-jquipicker" => '{"yearRange":"2000:2020"}', :class => "jquids_dp")
      end

    end

  end

  describe "The jsonify_opts function" do

    describe "without :datepicker_options or :timepicker_options" do

      it "doesn't change the options hash" do
        options = {}
        jsonify_opts(options)
        options.should == {}
      end

    end

    describe "with some :datepicker_options" do
      
      it "will add 'data-jquipicker' key and remove the :datepicker_options key" do
        options = {:datepicker_options => {:autoSize => true}}
        jsonify_opts(options)
        options.should == {"data-jquipicker" => '{"autoSize":true}'}
      end

    end

    describe "with some :timepicker_options and some :datepicker_options" do
      
      it "will add 'data-jquipicker' key and remove the :timepicker_options and :datepicker_options keys" do
        options = {:datepicker_options => {:autoSize => true}, :timepicker_options => {:ampm => true}}
        jsonify_opts(options)
        options.should == {"data-jquipicker" => '{"autoSize":true,"ampm":true}'}
      end

    end

    describe "with some :timepicker_options" do
      
      it "will add 'data-jquipicker' key and remove the :datepicker_options key" do
        options = {:timepicker_options => {:ampm => true}}
        jsonify_opts(options)
        options.should == {"data-jquipicker" => '{"ampm":true}'}
      end

    end

  end

  describe "The js_ui_ds_class function" do

    describe "with blank options" do
      
      it "will return 'jquids_dp'" do
        options = {}
        jquids_class(options).should == "jquids_dp"
      end

    end

    describe "with options of :time => true" do

      before(:each) do
        @options = {:time => true}
        @result = jquids_class(@options)
      end
      
      it "will return 'jquids_dtp'" do
        @result.should == "jquids_dtp"
      end

      it "will remove :time from options" do
        @options.should == {}
      end

    end

    describe "with options of :calendar => false, :time => true" do
      
      before(:each) do
        @options = {:calendar => false, :time => true}
        @result = jquids_class(@options)
      end

      it "will return 'jquids_tp'" do
        @result.should == "jquids_tp"
      end

      it "will remove :calendar and :time" do
        @options.should == {}
      end

    end

  end

end
