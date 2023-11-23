class ImagesController < ApplicationController
  #validate user 'has admin rights or not'
  before_action :checking_rights, only: [:destroy]
  
  #destroy specific image
  def destroy
    if (params[:image_id])
      Image.where(_id: params[:image_id]).destroy
    end
  end
end