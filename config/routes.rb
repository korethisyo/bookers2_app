Rails.application.routes.draw do
  get 'comments/create'
  get 'comments/destroy'
  devise_for :users
  root to:'home#top'
  get 'home/about' => 'home#about'
  resources:books, only:[:new, :create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, only:[:create, :destroy]
    resources :comments, only:[:create, :destroy]
  end
  resources:users, only:[:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end
  get '/search' => 'search#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
