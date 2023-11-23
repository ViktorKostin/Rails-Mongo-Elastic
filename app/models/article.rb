class Article
  include Mongoid::Document
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  index_name "articles-#{Rails.env}"


  field :title, type: String
  field :content, type: String
  field :author, type: String
  field :img, type: String

  def as_indexed_json (options={})
    as_json(except: [:id, :_id])
  end

	settings index: { number_of_shards: 1 } do
	  mappings dynamic: 'false' do
	    indexes :title, analyzer: 'english'
	    indexes :content, analyzer: 'english'
	    indexes :img, analyzer: 'english'
	  end
	end
  def self.search(query)
	  __elasticsearch__.search(
	    {
	      query: {
	        multi_match: {
	          query: query,
	          fields: ['title^10', 'text','author^10', 'text','content^10', 'text']
	        }
	      },
	      highlight: {
	        pre_tags: ['<em>'],
	        post_tags: ['</em>'],
	        fields: {
	          title: {},
	          text: {}
	        }
		    }
		  }
	  )
	end
	# Delete the previous articles index in Elasticsearch
	Article.__elasticsearch__.client.indices.delete index: Article.index_name rescue nil

	# Create the new index with the new mapping
	Article.__elasticsearch__.client.indices.create \
	  index: Article.index_name,
	  body: { settings: Article.settings.to_hash, mappings: Article.mappings.to_hash }

	# Index all article records from the DB to Elasticsearch
	Article.import
end
