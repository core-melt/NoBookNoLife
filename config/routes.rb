Rails.application.routes.draw do
  root 'homes#top'
  get 'homes/about'
  devise_for :users
  resources 'reading_books', only: [:show, :create, :destroy, :update]

  get 'books/index'
  resource 'books', only: [:show] do
      resource :book_nices, only: [:create, :destroy]
      resource :book_comments, only: [:create]
  end
  #post 'search' => 'books#search', as: 'search'
  resources 'users', only: [:show, :destroy, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
  end

  get 'relationships/follower' => 'relationships#follower', as: 'follower'
  get 'relationships/follow' => 'relationships#follow', as: 'follow'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
