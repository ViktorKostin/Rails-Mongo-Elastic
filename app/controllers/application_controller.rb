class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
    #check admin or ordinary user
    def checkingRights
      if user_signed_in? and current_user.rights != 'admin'
        redirect_to :home
      end
    end
end
