Rails.application.routes.draw do

  # get 'friends/index'
  root to: "home#index"
  devise_for :users,  controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :home
  resources :users
  resources :friends
  resources :orders do
    get '/:status', to: 'orders#update_status', as: 'update_status'
    resources :details
  end 
                                         
end
