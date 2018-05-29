Rails.application.routes.draw do
  devise_for :users, skip: [:sessions, :registrations], controllers: { confirmations: 'confirmations' }

  authenticated :user do
    root 'home#index', as: :authenticated_root
  end

  as :user do
    get 'login', to: 'devise/sessions#new', as: :new_user_session
    post 'login', to: 'devise/sessions#create', as: :user_session
    delete 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session

    get 'profile', to: 'devise/registrations#edit', as: :edit_profile
    patch 'profile', to: 'devise/registrations#update', as: :profile
    get 'unlock_account', to: 'devise/registration#new', as: :new_user_registration

    root 'devise/sessions#new'
  end

  resources :users
  post 'users/invite', to: 'users#invite', as: :invite_user

  resources :issues, except: :show
  get 'issues/:id', to: redirect('issues/%{id}/edit')
end
