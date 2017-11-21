class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  #paginator configuration
  paginates_per 6

  #table fields
  field :title, type: String
  field :content, type: String

  #articles indexing
  index({ created_at: 1 }, { background: true })

  #reference to images, that compilance specific article
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
        sort: { created_at: {order: :desc} },
        size: 30
      }
    )
  end
end
