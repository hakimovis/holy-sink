class MyDaysController < ApplicationController
  include DateSelector

  helper_method :user_days

  def index
    redirect_to my_days_path(year: current_year, month: current_month) unless valid_year? && valid_month?
  end

  def create
    if create_type == :day_status
      process_create_day_status
    elsif create_type == :day_icon
      process_create_day_icon
    end

    head :ok
  end

  def create_type
    params[:type].to_s.to_sym
  end

  def process_create_day_status
    date, status = parse_day_id(params.require('id'))
    day = user_day(date)
    day.status = status
    day.save!
  end

  def process_create_day_icon
    date, icon = parse_day_id(params.require('id'))
    day = user_day(date)
    day.icon = icon.to_s
    day.save!
  end

  def user_day(date)
    Day.find_or_initialize_by(user: current_user, team_name: current_team[:name], date: date)
  end

  def parse_day_id(day_id)
    # 'day-20240108-free'
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

  def update_comment
    date_str = params.require('id').match(/comment\-(\d+)/)[1]
    return head :not_found unless date_str

    date = Date.strptime(date_str, "%Y%m%d")
    day = user_day(date)
    day.comment = params['value'].to_s
    day.save!

    head :ok
  end
end
