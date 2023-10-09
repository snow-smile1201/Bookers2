class BooksController < ApplicationController
  before_action :is_matching_book_author, only: [:edit, :update]

  def index
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    if params[:latest]
      @books = Book.latest
    elsif params[:old]
      @books = Book.old
    elsif params[:star_count]
      @books = Book.star_count
    else
      @books = Book.includes(:favorites).sort_by { |book| -book.favorites.where(created_at: from...to).count }
    end
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    @book_detail = Book.find(params[:id])
    unless ViewCount.find_by(user_id: current_user.id, book_id: @book_detail.id)
      current_user.view_counts.create(book_id: @book_detail.id)
    end
  end

  def create
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    tag_names = params[:book][:tag_names]
    
    if @book.save
      if tag_names.present?
        tags = tag_names.split("/n").map(&:strip).uniq
        create_or_update_book_tags(@book, tags)
      end
       flash[:notice] = "Book was successfully created!"
       redirect_to book_path(@book.id)
    else
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      if tag_names.present?
        tags = tag_names.split("/n").map(&:strip).uniq
        create_or_update_book_tags(@book, tags)
      end
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
    params.require(:book).permit(:title, :body, :star)
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_book_author
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
      redirect_to books_path
    end
  end
  
  def create_or_update_book_tags(book, tags)
    book.tags.destroy_all
    begin
    tags.each do |tag|
      tag = Tag.find_or_create_by(name: tag)
      book.tags << tag
      rescue ActiveRecord::RecordInvalid
        false
      end
    end
  end
end