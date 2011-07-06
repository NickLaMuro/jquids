module JqUiDateSelect
  FORMATS = {
    :natural => {
      :date => "%B %d, %Y",
      :time => " %I:%M %p",
      :js_date => "MM dd, yy",
      :tr_js_time => "hh:mm TT",
      :ampm => true
    },
    :hyphen_ampm => {
      :date => "%Y-%m-%d",
      :time => " %I:%M %p",
      :js_date => "yy-mm-dd",
      :tr_js_time => "hh:mm TT",
      :ampm => true
    },
    :iso_date => {
      :date => "%Y-%m-%d",
      :time => " %H:%M",
      :js_date => "yy-mm-dd",
      :tr_js_time => "hh:mm",
      :ampm => false
    },
    :finnish => {
      :date => "%d.%m.%Y",
      :time => " %H:%M",
      :js_date => "dd.mm.yy",
      :tr_js_time => "hh:mm",
      :ampm => false
    },
    :danish => {
      :date => "%d/%m/%Y",
      :time => " %H:%M",
      :js_date => "dd/mm/yy",
      :tr_js_time => "hh:mm",
      :ampm => false
    },
    :american => {
      :date => "%m/%d/%Y",
      :time => " %I:%M %p",
      :js_date => "mm/dd/yy",
      :tr_js_time => "hh:mm TT",
      :ampm => true
    },
    :euro_24hr => {
      :date => "%d %B %Y",
      :time => " %H:%M",
      :js_date => "dd MM yy",
      :tr_js_time => "hh:mm",
      :ampm => false
    },
    :euro_24hr_ymd => {
      :date => "%Y.%m.%d",
      :time => " %H:%M",
      :js_date => "yy.mm.dd",
      :tr_js_time => "hh:mm",
      :ampm => false
    },
    :italian => {
      :date => "%d/%m/%Y",
      :time => " %H:%M",
      :js_date => "dd/mm/yy",
      :tr_js_time => "hh:mm",
      :ampm => false
    },
    :db => {
      :date => "%Y-%m-%d",
      :time => " %H:%M",
      :js_date => "yy-mm-dd",
      :tr_js_time => "hh:mm",
      :ampm => false
    }
  }
end
