module MyDaysHelper
  def day_status_id(date, status)
    "day-#{date.strftime('%Y%m%d')}-#{status}"
  end

  def day_icon_id(date, icon)
    "dayicon-#{date.strftime('%Y%m%d')}-#{icon}"
  end

  def day_comment_id(date)
    "comment-#{date.strftime('%Y%m%d')}"
  end

  def day_status_css_classes(day, status_to_show)
    day && day.status == status_to_show.to_s ? 'selected' : 'bg-light'
  end

  def day_icon_css_classes(day, icon_to_show)
    day && day.icon == icon_to_show.to_s ? 'selected' : ''
  end

  def date_css_classes(date)
    holiday = date.sunday? || date.saturday?
    holiday ? 'date-holoday' : ''
  end
end
