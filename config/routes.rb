Rails.application.routes.draw do

  get 'hello_world', to: 'hello_world#index'
  devise_for :users, controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  resources :users, only: [:edit, :update, :destroy] do
    resources :clients
  end

  resources :projects do
    resources :tasks, except: :index
    resources :expenses, except: :index
  end
end
