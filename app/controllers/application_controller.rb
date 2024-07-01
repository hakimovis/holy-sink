class ApplicationController < ActionController::Base
  helper_method :current_team, :current_user, :team_users

  def current_team
    session[:current_team]&.symbolize_keys
  end

  def current_user
    User.find_by id: (session[:current_user] || {})['id']
  end

  def team_users
    User.where(team_name: current_team[:name])
  end

  def set_current_team(team)
    session[:current_team] = team
  end

  def set_current_user(user)
    session[:current_user] = user
  end

  def require_team!
    redirect_to root_path unless current_team
  end

  def require_user!
    redirect_to user_login_index_path unless current_team.present? && current_user.present?
  end

  def redirect_if_team_selected!
    redirect_to user_login_index_path if current_team.present?
  end

  def redirect_if_user_logged_in!
    redirect_to my_days_path if current_user.present?
  end
end
