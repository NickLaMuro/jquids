module JqUiDateSelect

  FORMATS = {
    :natural => {
      :date => "%B %d, %Y",
      :time => " %I:%M %p",
      :js_date => "MM dd, yy"
    },
    :hyphen_ampm => {
      :date => "%Y-%m-%d",
      :time => " %I:%M %p",
      :js_date => "yy-mm-dd"
    },
    :iso_date => {
      :date => "%Y-%m-%d",
      :time => " %H:%M",
      :js_date => "yy-mm-dd"
    },
    :finnish => {
      :date => "%d.%m.%Y",
      :time => " %H:%M",
      :js_date => "dd.mm.yy"
    },
    :danish => {
      :date => "%d/%m/%Y",
      :time => " %H:%M",
      :js_date => "dd/mm/yy"
    },
    :american => {
      :date => "%m/%d/%Y",
      :time => " %I:%M %p",
      :js_date => "mm/dd/yy"
    },
    :euro_24hr => {
      :date => "%d %B %Y",
      :time => " %H:%M",
      :js_date => "dd MM yy"
    },
    :euro_24hr_ymd => {
      :date => "%Y.%m.%d",
      :time => " %H:%M",
      :js_date => "yy.mm.dd"
    },
    :italian => {
      :date => "%d/%m/%Y",
      :time => " %H:%M",
      :js_date => "dd/mm/yy"
    },
    :db => {
      :date => "%Y-%m-%d",
      :time => " %H:%M",
      :js_date => "yy-mm-dd"
    }
  }

  def self.format=(key)
    raise JqUiDateSelect::NotAKnownFormat, "JqUiDateSelect: Unrecognized format specification: #{key}" unless FORMATS.has_key?(key)
    @jq_ui_date_select_format = FORMATS[key]
  end

  def self.format
    @jq_ui_date_select_format ||= FORMATS[:natural]
  end

end
