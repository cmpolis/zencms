Zencms::Application.routes.draw do
  devise_for :users, :skip => [:registrations, :sessions] do
    get 'register' => 'devise/registrations#new', :as => :new_user_registration
    post 'register' => 'devise/registrations#create', :as => :user_registration
    
    get 'login' => 'devise/sessions#new', :as => :new_user_session
    post 'login' => 'devise/sessions#create', :as => :user_session
    delete 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  root 'pages#show', :defaults => { :path => '' }

  namespace :admin do
    get '', to: 'dashboard#index', as: :dashboard
    resources :users
    resources :types do
      resources :properties
    end
    resources :collections do
      resources :entities
    end
    resources :styles
    resources :scripts
    resources :layouts do
      resources :scripts
      resources :styles
    end
    resources :statics
    resource :config

    # Dynamic resource names...
    get 'entity/:type_name', to: 'entities#index', as: 'entity_list'
    get 'entity/:type_name/new', to: 'entities#new', as: 'new_list'
    get 'entity/:type_name/:id', to: 'entities#show', as: 'entity'
    patch 'entity/:type_name/:id', to: 'entities#update', as: 'update_entity'
    post 'entity/:type_id', to: 'entities#create', as: 'create_entity'
    delete 'entity/:type_id/:id', to: 'entities#destroy', as: 'destroy_entity'
  end

  get 'js/:script_name', to: 'scripts#show', as: 'cms_script'
  get 'css/:style_name', to: 'styles#show', as: 'cms_style'
  get ':path', to: 'pages#show', as: 'cms_page'

end
