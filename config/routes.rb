Rails.application.routes.draw do
  devise_for :users
  resources :articles
  root to: 'articles#index', :as => :home
  delete 'images', to: 'images#destroy', :as => :image_destroy
end
