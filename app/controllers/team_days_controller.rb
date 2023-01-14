class TeamDaysController < ApplicationController
  include DateSelector

  helper_method :team_days, :team_days_by_date, :selected_days_by_weeks

  def index
  end

  def team_days
    Day.where(team_name: current_team[:name], date: selected_days).includes(:user)
  end

  def team_days_by_date
    team_days.group_by(&:date)
  end

  def selected_days_by_weeks
    @_days_by_weeks ||= Calendar.group_by_weeks(selected_days)
  end
end
