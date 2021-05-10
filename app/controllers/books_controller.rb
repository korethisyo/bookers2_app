class BooksController < ApplicationController
  before_action :ensure_user, only:[:edit, :update, :destroy]

  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
    flash[:notice] = "You have created book successfully."
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    @user = @book.user
    @comment = Comment.new
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book[:id])
    else
      render :edit
    end
    flash[:notice] = "You have updated book successfully."
  end

  def destroy
    @book.destroy
    redirect_to  books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

  def ensure_user
    @books = current_user.books
    @book = @books.find_by(id: params[:id])
    redirect_to books_path unless @book
  end
end
