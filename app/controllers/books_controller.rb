class BooksController < ApplicationController
  def index
    @user = current_user
    @books = Book.all
    @newbook = Book.new
  end

  def show
    @user = current_user
    @book = Book.find(params[:id])
    @newbook = Book.new
  end

  def create
    @user = current_user
    @books = @user.books
    @newbook = Book.new(book_params)
    @newbook.user_id = current_user.id
    if @newbook.save
       flash[:notice] = "Book wad successfully created!"
       redirect_to book_path(@newbook.id)
    else
      render :index
    end
  end

  def edit
    @user = current_user
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] = "Book was successfully updated!"
       redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] = "Book was successfully destroyed."
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end

