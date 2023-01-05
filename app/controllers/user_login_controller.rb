class UserLoginController < ApplicationController
  helper_method :user

  def index
  end

  def show
    render :index
    # user = User.find_by(id: params.require(:id))
    # redirect_to user_login_index_path, alert: "Нет такого юзера" unless user

    # set_current_user(user)

    # redirect_to user_login_index_path, notice: "Вход как юзер #{user.name}"
  end

  def create
    user = User.find_or_initialize_by(name: form_params[:name])
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

  private

  def set_current_user(user)
    session[:current_user] = user
  end
end
