module JqUiDateSelect

  require File.dirname(__FILE__) + "/constants/formats.rb"

  # Sets the format for the jq_ui_date_select class
  #   If a format doesn't exist, and error is through
  #   Else the format variable is set
  def self.format=(key)
    raise JqUiDateSelect::NotAKnownFormat, "JqUiDateSelect: Unrecognized format specification: #{key}" unless FORMATS.has_key?(key)
    @jq_ui_date_select_format = FORMATS[key]
  end

  # Gets the format variable
  #   If a format is set, it grabs it
  #   Else it will set it to the default format (:natural)
  def self.format
    @jq_ui_date_select_format ||= FORMATS[:natural]
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

end
