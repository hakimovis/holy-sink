class ApplicationController < ActionController::Base
  helper_method :current_team, :current_user

  def current_team
    session[:current_team]
  end

  def current_user
    User.find_by id: (session[:current_user] || {})['id']
  end
end
