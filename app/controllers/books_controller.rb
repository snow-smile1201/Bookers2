class BooksController < ApplicationController
  def index
    @user = current_user
    @books = Book.all
  end

  def create
    @newbook = Book.new(book_params)
    @newbook.user_id = current_user.id
    @newbook.save
    redirect_to users_path
  end

  def show

  end

  def edit

  end

  def update

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

