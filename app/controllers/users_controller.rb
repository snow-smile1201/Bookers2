class UsersController < ApplicationController
  def index
    @user = current_user
    @users = User.all
    @books = Book.all
    @newbook = Book.new
  end

  def show
    @user = current_user
    @books = @user.books
    @newbook = Book.new
  end

  def create
   
  end

  def edit
    @user = User.find(params[:id])

  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successgfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
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


