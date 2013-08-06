Zencms::Application.routes.draw do
  devise_for :users
  root 'pages#welcome'

  namespace :admin do
    resources :users
    resources :types
    resources :entities
    resources :collections
    resources :layouts
    resource :config
  end

end
