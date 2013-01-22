# Harvestman

Harvestman is a lightweight, simple, thread-safe web crawler.

## Installation

Add this line to your application's Gemfile:

    gem 'harvestman'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install harvestman

## Basic usage

Harvestman is fairly simple to use: you specify the URL to crawl and pass in a block.
Inside the block you can call the ``css`` (or ``xpath``) method to search the HTML document (see [Nokogiri](http://nokogiri.org/tutorials/searching_a_xml_html_document.html)).
By default, these methods will return the inner text inside the node.

###### Perhaps this is best understood with an example:

```ruby
Harvestman.crawl "http://www.24pullrequests.com" do
  headline = xpath "//h3"
  catchy_phrase = css "div.visible-phone h3"

  puts "Headline: #{headline}"
  puts "Catchy phrase: #{catchy_phrase}"
end
```

## One node to rule them all

Harvestman assumes there's only one node at the path you passed to the ``css`` (or ``xpath``) method (it's like calling Nokogiri's ``at_css`` method).
If there is more than one node at that path, you should pass in an additional block.

###### Another example:

```ruby
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
```

Note that inside the block we use ``css("a")`` and *not* ``css("div#mp-sister b a")``. Calls to ``css`` or ``xpath`` here assume ``div#mp-sister b`` is the parent node.

## Pages / Search results

If you want to crawl a group of similar pages (eg: search results, as shown above), you can insert a ``*`` somewhere in the URL string and it will be replaced by each element in the second argument.

###### Final example:

```ruby
require 'harvestman'

Harvestman.crawl 'http://www.etsy.com/browse/vintage-category/electronics/*', (1..3) do
  css "div.listing-hover" do
    title = css "div.title a"
    price = css "span.listing-price"

    puts "* #{title} (#{price})"
  end
end
```

The above code is going to crawl Etsy's electronics category pages (from 1 to 3) and output every item's title and price. Here we're using a range ``(1..3)`` but you could've passed an array with search queries:

    "http://www.site.com?query=*", ["dogs", "cats", "birds"]

## License

See LICENSE.

## Contributing

I'm accepting contributions of all sorts. This is the first version and the code base is very small, so feel free to add a new feature, refactor a method/class/module, add more tests, etc.
