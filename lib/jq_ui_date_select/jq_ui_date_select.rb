module JqUiDateSelect

  extend ActionView::Helpers::AssetTagHelper
  require File.dirname(__FILE__) + "/constants/formats.rb"

  # Sets the format for the jq_ui_date_select class
  #   If a format doesn't exist, and error is through
  #   Else the format variable is set
  def self.format=(key)
    raise JqUiDateSelect::NotAKnownFormat, "JqUiDateSelect: Unrecognized format specification: #{key}" unless JqUiDateSelect::FORMATS.has_key?(key)
    @jq_ui_date_select_format = JqUiDateSelect::FORMATS[key]
  end

  # Gets the format variable
  #   If a format is set, it grabs it
  #   Else it will set it to the default format (:natural)
  def self.format
    @jq_ui_date_select_format ||= JqUiDateSelect::FORMATS[:natural]
  end

  # Gets a format string based off of the current format
  #   The format string will always return the date portion of the format
  #
  #   If a true is passed for time, the time string will be tacked on to the string
  #   Else it will return just the date string
  def self.date_format_string(time = false)
    format[:date] + (time ? format[:time] : "")
  end

  # Formats a date or datetime/time object to the default format
  #   This method is assumed that you send it a Date, Datetime, or Time object
  #   
  #   If sent a Date, the format will NOT use the time in the format string
  #   Else, it WILL use the time in the format string
  def self.format_date(date)
    if date.is_a?(Date) && !date.is_a?(DateTime)
      date.strftime(date_format_string(false))
    else
      date.strftime(date_format_string(true))
    end
  end

  # Returns the value that will go in the form builder's input field when the field is
  # initialized.
  #   This will detect if it is a date or not, and format it if it is
  #
  #   If the value sent to the method is a Date
  #     If the options hash has :time, format the result with the time included
  #     Else format the result without the time
  #   Else return the given value as the result (with no changes)
  def self.format_time(value, options = {})
    return value unless value.respond_to?("strftime")
    if options[:time]
      format_date(value)
    else
      format_date(value.is_a?(Date) ? value : value.to_date)
    end

  end

  # Processes old CalendarDateSelect options and converts them to the
  # coresponding jQuery UI options values for the timepicker and datepicker.
  #
  # If no keys exist for :timepicker_options or :datepicker options, they are
  # removed to avoid the client side processing.
  def self.jq_ui_date_select_process_options(options = {})
    options[:datepicker_options] ||= {}
    options[:timepicker_options] ||= {}

    if options.has_key?(:year_range)
      if options[:year_range].respond_to?(:first)
        options[:datepicker_options][:yearRange] = options[:year_range].first.respond_to?(:strftime) ? 
          "#{options[:year_range].first.strftime("%Y")}:#{options[:year_range].last.strftime("%Y")}" : "#{options[:year_range].first}:#{options[:year_range].last}"
      else
        options[:datepicker_options][:yearRange] = options[:year_range].respond_to?(:strftime) ? 
          "#{options[:year_range].strftime("%Y")}:#{options[:year_range].strftime("%Y")}" : "#{options[:year_range]}:#{options[:year_range]}"
      end
      options.delete(:year_range)
    end

    if options[:month_year] == "dropdowns"
      options[:datepicker_options][:changeMonth] = true
      options[:datepicker_options][:changeYear] = true
    elsif options[:month_year] == "labels"
      options[:datepicker_options][:changeMonth] = false
      options[:datepicker_options][:changeYear] = false
    end
    options.delete(:month_year)

    if options.has_key?(:minute_interval) and options[:minute_interval].is_a?(Numeric)
      options[:timepicker_options][:stepMinute] = options[:minute_interval] 
    end
    options.delete(:minute_interval)

    if options.delete(:popup).to_s == 'force'
      options[:readonly] = true
    end

    if default_time = options.delete(:default_time)
      options[:datepicker_options][:defaultDate] = 
        if default_time.respond_to? :strftime
          default_time.strftime(JqUiDateSelect.date_format_string(false))
        else
          default_time
        end
      if default_time.respond_to?(:hour)
        options[:timepicker_options][:hour] = default_time.hour
        options[:timepicker_options][:minute] = default_time.min
        options[:timepicker_options][:second] = default_time.sec
      end
    end

    if options.has_key?(:image)
      options[:datepicker_options][:showOn] ||= 'button'
      options[:datepicker_options][:buttonImageOnly] = true
      options[:datepicker_options][:buttonImage] = image_path(options[:image])
      options.delete(:image)
    end

    # For slightly trimming unneeded html, and for less client side processing
    options.delete(:datepicker_options) if options[:datepicker_options].keys.count <= 0
    options.delete(:timepicker_options) if options[:timepicker_options].keys.count <= 0
    options
  end

end
