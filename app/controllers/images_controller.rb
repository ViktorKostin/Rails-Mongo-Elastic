class ImagesController < ApplicationController
	#validate user 'has admin rights or not'
  before_action :checkingRights, only: [:edit, :create, :update, :destroy, :new]

	
	def destroy options={}
		#destroy all images from specific article
    Image.where(article_id: options[:article_id]).destroy

    #destroy specific image
		if (params[:image_id] rescue nil)
			Image.where(_id: params[:image_id]).destroy
		end
	end

	private
		#check admin or ordinary user
	  def checkingRights
	    if user_signed_in? and current_user.rights != 'admin'
	      redirect_to :home
	    end
	  end
end