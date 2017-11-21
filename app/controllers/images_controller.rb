class ImagesController < ApplicationController
  #validate user 'has admin rights or not'
  before_action :checkingRights, only: [:destroy]
  
  #destroy specific image
  def destroy
    if (params[:image_id] rescue nil)
      Image.where(_id: params[:image_id]).destroy
    end
  end
end