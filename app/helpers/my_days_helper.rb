module MyDaysHelper

  def day_status_id(date, status)
    "day-#{date.strftime('%Y%m%d')}-#{status}"
  end

  def day_comment_id(date)
    "comment-#{date.strftime('%Y%m%d')}"
  end

  def day_css_classes(day, status_to_show)
    day && day.status == status_to_show.to_s ? 'selected' : 'bg-light'
  end

  def date_css_classes(date)
    holiday = date.sunday? || date.saturday?
    holiday ? 'date-holoday' : ''
  end
end
