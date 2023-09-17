Rails.application.routes.draw do
  get 'users/new'
  get 'users/index'
  get 'users/edit'
  get 'users/show'
  get 'books/new'
  get 'books/index'
  get 'books/edit'
  get 'books/show'
  devise_for :users
  root to: 'homes#top'
  get 'homes/about' => 'homes#about', as: 'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
