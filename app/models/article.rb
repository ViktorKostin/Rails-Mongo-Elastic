class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  #paginator configuration
	paginates_per 6
	max_paginates_per 10000

	#table fields
  field :title, type: String
  field :content, type: String

  #articles indexing
  index({ created_at: 1 }, { background: true })

  #reference to images, that compilance specific article
  attr_accessor :images
  has_many :images
  accepts_nested_attributes_for :images, :allow_destroy => true

  #set index name
  index_name "articles-#{Rails.env}"

  #makes serialization
  def as_indexed_json (options={})
    as_json(except: [:id, :_id])
  end


	#search parameters
  def self.search(query)
	  __elasticsearch__.search(
	    {
	      query: {
	        multi_match: {
	          query: query,
	          fields: ['title^10', 'text', 'content^10', 'text']
	        }
	      },
		    size: 30
		  }
	  )
	end

	#delete the previous articles index in Elasticsearch
	Article.__elasticsearch__.client.indices.delete index: Article.index_name rescue nil

	#create the new index with the new mapping
	Article.__elasticsearch__.client.indices.create \
	  index: Article.index_name,
	  body: { settings: Article.settings.to_hash, mappings: Article.mappings.to_hash }

	#index all article records from the Mongo to Elasticsearch
	Article.import
end
