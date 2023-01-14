class TeamLoginController < ApplicationController
  before_action :redirect_if_team_selected!

  def index
  end

  def create
    password = form_params[:password]

    team_password = selected_team[:password]

    return redirect_to team_login_index_path, alert: "Неправильная команда" unless team_password.present?
    return redirect_to team_login_index_path, alert: "Неправильный пароль" unless team_password == password

    set_current_team(selected_team)

    redirect_to user_login_index_path
  end

  def selected_team
    team_name = form_params[:team]
    Settings.teams.find {|t| t.name == team_name } || {}
  end

  def form_params
    params.require(:team).permit(:team, :password)
  end

  def log_out
    set_current_team(nil)
    set_current_user(nil)

    redirect_to team_login_index_path, notice: "Вы вышли"
  end
end
