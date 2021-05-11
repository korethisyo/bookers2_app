class FavoritesController < ApplicationController
  def create
    book = Book.find_by(id: params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    favorite.save
    redirect_to book_path(book.id)
  end

  def destroy
    book = Book.find_by(id: params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    binding.pry
    redirect_to book_path(book.id)
  end
end