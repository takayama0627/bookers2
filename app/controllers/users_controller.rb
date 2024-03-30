class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:top]
  def index
    @users = User.all
    @books = Book.all
    @book = Book.new
    @user = User.find(current_user.id)
  end

  def show
    @users = User.all
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    is_matching_login_user
    @user = User.find(params[:id])
  end

  def update
    is_matching_login_user
    @user = User.find(current_user.id)
    @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    if @user.update(user_params)
      redirect_to(user_path(@user.id))
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end
end
