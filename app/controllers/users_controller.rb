class UsersController < ApplicationController

  def index
    @user = current_user
    @books = Book.all
    @users = User.all
  end

  def create
    
  end

  def show
    @user = current_user
    @books = @user.books

  end

  def edit
    @user = current_user

  end

  def update
    @user = current_user

  end

  def destroy

  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  def user_params
    params.require(:user).permit(:id, :name, :introduction)
  end
end


