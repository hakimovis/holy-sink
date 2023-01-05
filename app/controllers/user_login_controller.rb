class UserLoginController < ApplicationController
  helper_method :user, :team_users

  def index
  end

  def show
    render :index
  end

  def create
    user = User.find_or_initialize_by(name: form_params[:name], team_name: current_team[:name])
    user.save! if user.new_record?
    set_current_user(user)

    redirect_to user_login_index_path, notice: "Вы вошли как юзер #{user.name}"
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

  def team_users
    User.where(team_name: current_team[:name])
  end

  private

end
