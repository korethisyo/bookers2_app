class SearchController < ApplicationController
  def search
    @content = params[:content]
    @model = params[:model]
    @method = params[:method]
    if @model == 'user'
      @users = User.search_for(@content, @method)
    else
      @books = Book.search_for(@content, @method)
    end
  end
end
