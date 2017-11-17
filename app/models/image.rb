class Image
  include Mongoid::Document
  include Mongoid::Paperclip

  #reference many images to specific article
  belongs_to :article

  #set images attributes
  has_mongoid_attached_file :image,
      :url => "/:attachment/:id/:style/:filename",
	    :styles => {
	      :original => ['1920x1680>', :jpg],
	      :large    => ['500x500>',   :jpg],
	      :medium   => ['250x250',    :jpg],
	      :small    => ['100x100#',   :jpg]
	    }

  #set image validation
  validates_attachment_content_type :image, :content_type => %w(image/jpeg image/jpg image/png image/gif)
end
