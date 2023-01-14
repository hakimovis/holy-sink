module ApplicationHelper
  def bootstrap_class_for(flash_type)
    {notice: "alert-info", success: "alert-success", error: "alert-danger", alert: "alert-danger"}.
      fetch(flash_type.to_sym, "alert-#{flash_type}")
  end

  def flash_messages
    output_html = "".html_safe

    flash.each do |flash_type, message|
      css_class = bootstrap_class_for(flash_type) || flash_type.to_s
      output_html += content_tag(:div, message, class: "alert #{css_class}", role: "alert") do
        message
      end
    end

    output_html
  end
end
