Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'confirmations' }

  root to: 'home#index'

  resources :users, except: :create
  post 'invite_user', to: 'users#create', as: :invite_user

  resources :issues, except: :show
  get '/issues/:id', to: redirect('issues/%{id}/edit')
  # get '/issues/:id', to: 'issues#edit'
end
