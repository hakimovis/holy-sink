module TeamDaysHelper
  def day_popup_text(day)
    result = "#{day.user.name}: #{day.ru_status}."

    icon_data = day.icon.present? && Day::ICONS[day.icon.to_sym]
    if icon_data
      result << " #{icon_data[:tip]}."
    end

    if day.comment.present?
      result << " (#{day.comment})"
    end

    result
  end
end
