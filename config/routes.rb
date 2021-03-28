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
    delete 'invitation/:invitation_id', to: 'orders#destroy_invitation', as: 'destroy_invitation'

  end
  
  get 'order_invited_members', to: 'orders#search_invited', as: 'search_invited'
  get 'order_add_members/:member_id', to: 'orders#add_invited', as: 'add_invited'        
  get 'order_add_groups/:group_id', to: 'orders#add_invited', as: 'add_invited_group'  
  get 'order_remove_member/:remove_member_id', to: 'orders#remove_invited', as: 'remove_invited'


  get 'friends_list' => 'friends#listF'     
  get 'groups_list' => 'groups#listG'     
  get 'group_friend_list/:name' => 'groups#listGF'  

end
