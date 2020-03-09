Rails.application.routes.draw do
  devise_for :users
  resources 'reading_books', only: [:index, :create, :destroy]
  resources 'books', only: [:index, :show] do
      resource :book_nices, only: [:create, :destroy]
      resource :book_comments, only: [:create]
  end
  root to: 'homes/top'
  get 'homes/about'
  resources 'users', only: [:show, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
