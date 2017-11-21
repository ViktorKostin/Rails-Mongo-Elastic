desc 'Deleting index from elasticsearch'
task :delete_elastic => :environment do
  puts 'Start deleting index...'
  Article.__elasticsearch__.client.indices.delete index: Article.index_name rescue nil
  puts 'Deleting was successfully produced'
end