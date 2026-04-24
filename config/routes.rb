Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :stocks

  resources :chats, only: [:index, :show, :create, :update, :edit, :destroy] do
    resources :messages, only: [:create]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
