class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
    #check admin or ordinary user
    def checking_rights
      if user_signed_in? and current_user.rights != 'admin'
        redirect_to :home
      end
    end
end
