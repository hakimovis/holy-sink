class MyDaysController < ApplicationController
  include DateSelector

  helper_method :user_days

  def index
    redirect_to my_days_path(year: current_year, month: current_month) unless valid_year? && valid_month?
  end

  def create
    date, status = parse_day_id(params.require('id'))
    day = Day.find_or_initialize_by(user: current_user, team_name: current_team[:name], date: date)
    day.date = date
    day.status = status
    day.save!
  end


  def parse_day_id(day_id)
    'day-20240108-free'
    _, date_str, status = day_id.to_s.split('-')
    date = Date.strptime(date_str, "%Y%m%d")
    [date, status]
  end

  def user_days
    @_user_days ||= Day.for_user(current_user).
                      for_team(current_team[:name]).
                      for_month(selected_year, selected_month).
                      index_by(&:date)
  end
end
