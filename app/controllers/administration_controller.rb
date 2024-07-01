class AdministrationController < ApplicationController
  before_action :require_team!
  before_action :require_user!
  before_action :require_admin!

  def index
  end

  def destroy
    return unless find_user
    if current_user.admin? && current_user.team_name == @user.team_name
      @user.destroy
      redirect_with_message("Пользователь удален успешно")
    else
      redirect_with_message("Вы не можете удалить пользователя")
    end
  end

  private

  def redirect_with_message(string)
    session[:return_to] ||= request.referer
    redirect_to session.delete(:return_to), notice: string
  end

  def require_admin!
    redirect_to team_days_path unless current_user.admin?
  end

  def find_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_with_message("Пользователь не найден")
    nil
  end
end
