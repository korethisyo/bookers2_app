class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.new
    @user = User.find(params[:id])
    @user = User.new(user_params)
    @user.user_id = current_user.id
    @user.save
    redirect_to user_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image_id)
  end
end
