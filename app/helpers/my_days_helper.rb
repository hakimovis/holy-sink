module MyDaysHelper

  def day_id(date, status)
    "day-#{date.strftime('%Y%m%d')}-#{status}"
  end

  def css_classes_for(day, status_to_show)
    day && day.status == status_to_show.to_s ? 'selected' : 'bg-light'
  end
end
