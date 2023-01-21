module TeamDaysHelper
  def day_popup_text(day)
    result = "#{day.user.name}: #{day.ru_status}"

    if day.comment.present?
      result << " (#{day.comment})"
    end

    result
  end
end
