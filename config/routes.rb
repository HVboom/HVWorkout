# frozen_string_literal: true

Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users

    root controller: :static_pages, action: :home

    get '/home', to: 'static_pages#home'
    get '/about', to: 'static_pages#about'
  end

  # Catch all route
  get '*path', to: 'static_pages#home', locale: I18n.default_locale, constraints: lambda { |req| req.path.exclude? 'rails/' }
end
