require 'sinatra'
require 'sinatra/json'
require 'harvestman'

# def search(query, page)
get '/search' do
  query = params['query'] || ""
  page = params['page'] || "1"
  results = []
  Harvestman.crawl("http://plato.stanford.edu/search/search?page=#{page}&query=#{query}&prepend=None") do
    css(".result_listing") do
      results << {
        title: css(".result_title").inner_text.strip,
        snippet: css(".result_snippet").inner_text.strip,
        author: css(".result_author").inner_text.strip,
        url: css(".result_url").inner_text.strip
      }
    end
  end unless query.empty?
  json :results => results
end
