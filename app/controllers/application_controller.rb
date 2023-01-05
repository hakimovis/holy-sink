class ApplicationController < ActionController::Base
  helper_method :current_team, :current_user

  def current_team
    session[:current_team]&.symbolize_keys
  end

  def current_user
    User.find_by id: (session[:current_user] || {})['id']
  end

  def set_current_team(team)
    session[:current_team] = team
  end

  def set_current_user(user)
    session[:current_user] = user
  end
end
