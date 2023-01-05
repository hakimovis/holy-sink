class MyDaysController < ApplicationController
  helper_method :selected_days, :week_days, :month_names, :prev_month_year, :next_month_year

  def index
  end

  def selected_month
    month = params[:month].to_i
    valid_month?(month) ? month : Date.today.month
  end

  def selected_year
    year = params[:year].to_i
    valid_year?(year) ? year : Date.today.year
  end

  def selected_days
    first_date = Date.new(selected_year, selected_month, 1)
    last_date = first_date.end_of_month
    first_date..last_date
  end

  def valid_month?(month)
    month.in?(1..12)
  end

  def valid_year?(year)
    year.in?(2023..2024)
  end

  def week_days
    I18n.t('date.day_names', format: "")
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
