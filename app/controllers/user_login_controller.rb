class UserLoginController < ApplicationController
  helper_method :user
  before_action :require_team!
  before_action :redirect_if_user_logged_in!

  def index
  end

  def show
    return redirect_to user_login_index_path if user.new_record?
    render :index
  end

  def create
    user = team_users.find_or_initialize_by(name: form_params[:name], team_name: current_team[:name])
    user.save! if user.new_record?
    set_current_user(user)

    redirect_to my_days_path, notice: "Вы вошли как юзер #{user.name}"
  end

  def update
    create
  end

  def user
    User.find_or_initialize_by(id: params[:id])
  end

  def form_params
    params.require(:user).permit(:name)
  end

  # Можно вынести этот метод в application_controller?
  # def team_users
  #   User.where(team_name: current_team[:name])
  # end

  private

end
