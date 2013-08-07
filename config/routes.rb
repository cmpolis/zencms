Zencms::Application.routes.draw do
  devise_for :users, :skip => [:registrations, :sessions] do
    get 'register' => 'devise/registrations#new', :as => :new_user_registration
    post 'register' => 'devise/registrations#create', :as => :user_registration
    
    get 'login' => 'devise/sessions#new', :as => :new_user_session
    post 'login' => 'devise/sessions#create', :as => :user_session
    delete 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  root 'pages#welcome'

  namespace :admin do
    get '', to: 'dashboard#index', as: :dashboard
    resources :users
    resources :types do
      resources :properties
    end
    resources :collections
    resources :styles
    resources :layouts
    resource :config

    # Dynamic resource names...
    get 'entity/:type_name', to: 'entities#index', as: 'entity_list'
    get 'entity/:type_name/new', to: 'entities#new', as: 'new_list'
    get 'entity/:type_name/:id', to: 'entities#show', as: 'entity'
    post 'entity/:type_id', to: 'entities#create', as: 'create_entity'
    delete 'entity/:type_id/:id', to: 'entities#destroy', as: 'destroy_entity'
  end

end
