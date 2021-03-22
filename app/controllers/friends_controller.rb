class FriendsController < ApplicationController
  def index
    
    @friends = User.all
    return 'index'
  end
end
  # ds#index
  #                                        POST     /friends(.:format)            friends#create
  #                             new_friend GET      /friends/new(.:format)        friends#new
  #                            edit_friend GET      /friends/:id/edit(.:format)   friends#edit
  #                                 friend GET      /friends/:id(.:format)        friends#show
  #                                        PATCH    /friends/:id(.:format)        friends#update
  #                                        PUT      /friends/:id(.:format)        friends#update
  #                                        DELETE   /friends/:id(.:format)        friends#destroy