require 'harvestman'

Harvestman.crawl 'http://www.redmine.org/issues/*',['14822','14820'] do
  puts @uri

  description = css 'div.subject'

  puts "description: #{description}"

end
