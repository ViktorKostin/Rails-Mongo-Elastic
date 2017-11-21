desc 'Importing data from DB into elasticsearch'
task :integrate_elastic => :environment do
  puts 'Start import data...'
  #create the new index with the new mapping
  Article.__elasticsearch__.client.indices.create \
    index: Article.index_name,
    body: { settings: Article.settings.to_hash, mappings: Article.mappings.to_hash }

  #index all article records from the Mongo to Elasticsearch
  Article.import
  puts 'Import was successfully produced'
end