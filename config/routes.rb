Rails.application.routes.draw do
  devise_for :users

  root to: "homes#top"

  resources :books

  resources :users

  root to: "homes#top", as: "top"
  get 'home/about', to: 'homes#about', as: 'about'
  post 'books' => 'books#create'
  patch 'books/:id/update' => 'books#update', as: 'update_book'
  delete 'books/:id' => 'books#destroy', as: 'destroy_book'
end