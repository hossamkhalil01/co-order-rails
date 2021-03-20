class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    
    skip_before_action :verify_authenticity_token, only: [:facebook, :google_oauth2]
    


    def google_oauth2
        @user = User.from_omniauth(request.env['omniauth.auth'])
      
        if @user.persisted?
          flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
          binding.pry # to run console infironment and check alll the data that we have from API callback
          sign_in_and_redirect @user, event: :authentication
        else
          session['devise.google_data'] = request.env['omniauth.auth'].except('extra') # Removing extra as it can overflow some session stores
          redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
        end
      end

    def facebook
      @user = User.from_omniauth(request.env["omniauth.auth"])

      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
        set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
        binding.pry
      else
        session["devise.facebook_data"] = request.env["omniauth.auth"].except(:extra) # Removing extra as it can overflow some session stores
        redirect_to new_user_registration_url
      end
    end
  
    def failure
      redirect_to root_path
    end
  end