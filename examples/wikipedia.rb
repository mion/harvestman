require 'harvestman'

Harvestman.crawl 'http://en.wikipedia.org/wiki/Main_Page' do
  # Print today's featured article
  tfa = css "div#mp-tfa"

  puts "Today's featured article: #{tfa}"

  # Print all the sister projects
  sister_projects = []

  css "div#mp-sister b" do
    sister_projects << css("a")
  end

  puts "Sister projects:"
  sister_projects.each { |sp| puts "- #{sp}" }
end
