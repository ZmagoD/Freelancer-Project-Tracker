Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  resources :users, only: [:show, :edit, :update, :destroy] do
    resources :clients
  end

  resources :projects do
    resources :tasks, except: :index
    resources :expenses, except: :index
  end
end
