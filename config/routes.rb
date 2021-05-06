Rails.application.routes.draw do
  devise_for :users
  root to:'home#top'
  get 'home/about' => 'home#about'
  resources:books, only:[:new, :create, :index, :show, :edit, :update, :destroy]
  resources:users, only:[:index, :show, :edit, :update]
  get '/search' => 'search#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
