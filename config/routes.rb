Rails.application.routes.draw do
  resources :user_images
  root to: "home#index"
  devise_for :users,  controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :home
  resources :user_photos
end
