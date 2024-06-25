class AdministrationController < ApplicationController
  helper_method :team_users
  before_action :require_team!
  before_action :require_user!

  def index
  end

  def destroy
    @user_name = User.find(params[:id]).name
    User.destroy(params[:id])
    redirect_with_message("Пользователь #{@user_name} удален успешно")
  end

  def team_users
    User.where(team_name: current_team[:name])
  end

  private

  def redirect_with_message(string)
    session[:return_to] ||= request.referer
    redirect_to session.delete(:return_to), notice: string
  end
end
