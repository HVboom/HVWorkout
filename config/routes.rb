Rails.application.routes.draw do
  devise_for :users

  root controller: :static_pages, action: :home

  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
end
