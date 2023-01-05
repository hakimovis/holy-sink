module ApplicationHelper
  def current_team
    session[:current_team] || {}
  end
end
