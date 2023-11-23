Rails.application.routes.draw do
  devise_for :users
  resources :articles
  root to: 'articles#index', :as => :home
  get 'admin', to: 'admins#index', :as => :admin
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
