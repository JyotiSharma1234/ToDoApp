Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :developers, controller: :developers
  resources :tasks, controller: :tasks do
    get :start
    get :finish
  end
  resources :projects, controller: :projects
  get 'users/dashboard'
	devise_scope :user do
    authenticated :user do
      root 'users#dashboard', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
