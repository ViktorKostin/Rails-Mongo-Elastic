Rails.application.routes.draw do
  devise_for :users
  resources :articles
  get 'admin', to: 'admin#index', :as => :admin
  post 'admin/:id/edit', to: 'admin#edit'
  root to: 'articles#index', :as => :home
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
