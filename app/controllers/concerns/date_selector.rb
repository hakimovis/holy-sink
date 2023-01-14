module DateSelector
  extend ActiveSupport::Concern

  included do
    helper_method :current_month, :current_year
    helper_method :selected_month, :selected_year, :selected_days
    helper_method :valid_month?, :valid_year?
    helper_method :week_days, :month_names
    helper_method :prev_month_year, :next_month_year
  end

  def current_month
    Date.today.month
  end

  def current_year
    Date.today.year
  end

  def selected_month
    month = params[:month].to_i
    valid_month?(month) ? month : current_month
  end

  def selected_year
    year = params[:year].to_i
    valid_year?(year) ? year : current_year
  end

  def selected_days
    first_date = Date.new(selected_year, selected_month, 1)
    last_date = first_date.end_of_month
    first_date..last_date
  end

  def valid_month?(month = params[:month])
    month.to_i.in?(1..12)
  end

  def valid_year?(year = params[:year])
    year.to_i.in?(2023..2024)
  end

  def week_days(mon_first: false)
    result = I18n.t('date.day_names', format: "").dup
    result.push(result.shift) if mon_first
    result
  end

  def month_names
    I18n.t('date.month_names', format: "")
  end

  def prev_month_year
    date = selected_days.first - 1.day
    [date.month, date.year]
  end

  def next_month_year
    date = selected_days.last + 1.day
    [date.month, date.year]
  end
end
