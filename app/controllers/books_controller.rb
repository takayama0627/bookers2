class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:top]
  def index
    @user = User.find(current_user.id)
    @books = Book.all
    @book = Book.new
    @users = User.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = User.find(current_user.id)

    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      flash.now[:alert] = "Failed to create book."
      @books = Book.all
      render :index
    end
  end

  def show
    @books = Book.all
    @book = Book.find(params[:id])
    @user = @book.user
    @users = User.all
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
  end

  def update
    is_matching_login_user
    @book = Book.find(params[:id])
    @book.update(book_params)
    flash[:notice] = "You have updated book successfully."
    if @book.save
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_url
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    user = Book.find(params[:id]).user
    unless user.id == current_user.id
      redirect_to books_path
    end
  end
end