require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  authenticate :user do
  mount Sidekiq::Web => '/sidekiq'
  end

  root 'home#home'
end
