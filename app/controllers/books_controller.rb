class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @user = User.find(params[:user_id])
    @book = current_user.book.new(book_params)
    @book.user_id = user.id
    @book.save
    redirect_to books_path
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = current_user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    redirect_to book_path(@book[:id])
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to  books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
end
