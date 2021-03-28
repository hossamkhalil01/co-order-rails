Rails.application.routes.draw do

  root to: "home#index"

  devise_for :users,  controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :home
  resources :friends
  resources :users

  resources :groups do
    get '/member', to: 'groups#add_member', as: 'add_member'
    post '/member', to:	'groups#create_member', as: 'create_member'
    delete '/member/:member_id', to: 'groups#destroy_member', as: 'destroy_member'
    get 'search_member', to: 'groups#search'
  end

  resources :orders do
    get '/:status', to: 'orders#update_status', as: 'update_status'
    resources :details
  end 

  resources :notifications do 
    collection do 
    end 
  end

end
