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
    @user = User.find(params[:id])

  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def destroy

  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end


